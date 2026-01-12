require "faraday"
require "json"

class PsaVerifier
  def initialize(cert_number)
    @cert_number = cert_number.to_s.strip
    @grading_company = GradingCompany.find_by(code: "PSA")
  end

  def call
    response = fetch_psa_data

    if response[:success]
      slab = upsert_slab(response[:data])
      create_verification(slab, response[:data], true)
      { success: true, slab: slab }
    else
      create_verification(nil, response[:error], false)
      { success: false, error: response[:error] }
    end
  end

  private

  def fetch_psa_data
    token = Rails.application.credentials.dig(:psa, :token)
    return { success: false, error: "Missing PSA token" } if token.blank?

    url = "https://api.psacard.com/publicapi/cert/GetByCertNumber/#{@cert_number}"

    response = Faraday.get(url, {}, { "Authorization" => "bearer #{token}" })
    return { success: false, error: "PSA API error" } unless response.status == 200

    json = JSON.parse(response.body)
    cert = json["PSACert"]
    return { success: false, error: "Invalid PSA API format" } if cert.nil?

    mapped = {
      "cert" => cert["CertNumber"],
      "item" => {
        "name"  => "#{cert['Year']} #{cert['Brand']} #{cert['Subject']} #{cert['Variety']}".squeeze(" ").strip,
        "grade" => cert["CardGrade"]
      },
      "population" => {
        "total"   => cert["TotalPopulation"],
        "higher"  => cert["PopulationHigher"]
      },
      "image_url" => nil
    }


    { success: true, data: mapped }
  end

  def upsert_slab(data)
    cert_number = data["cert"]
    card_name   = data.dig("item", "name")
    grade       = data.dig("item", "grade")

    pop_total   = data.dig("population", "total")
    pop_higher  = data.dig("population", "higher")

    # Calculate % of this grade vs total population
    pop_percentage =
      if pop_total.to_i > 0
        ((pop_total - pop_higher).to_f / pop_total.to_f * 100).round(2)
      else
        nil
      end

    Slab.find_or_initialize_by(
      grading_company: @grading_company,
      cert_number: cert_number
    ).tap do |slab|
      slab.card_name              = card_name
      slab.grade                  = grade
      slab.population_total       = pop_total
      slab.population_higher      = pop_higher
      slab.population_percentage  = pop_percentage
      slab.extra_data             = data
      slab.verified               = true
      slab.save!
    end
  end


  def create_verification(slab, raw, success)
    Verification.create!(
      slab_id: slab&.id,
      raw_response: raw,
      success: success
    )
  end
end
