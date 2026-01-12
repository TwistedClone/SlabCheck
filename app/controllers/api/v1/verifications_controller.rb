module Api
  module V1
    class VerificationsController < ApplicationController
      def create
        cert_number = params[:cert_number]
        grading_company = params[:grading_company] || "PSA"

        verifier = case grading_company
                   when "PSA" then PsaVerifier
                   # later:
                   # when "BGS" then BeckettVerifier
                   # when "CGC" then CgcVerifier
                   end

        result = verifier.new(cert_number).call

        if result[:success]
          render json: serialize_slab(result[:slab])
        else
          render json: { error: result[:error] }, status: :not_found
        end
      end

      private

      def serialize_slab(slab)
        {
          id: slab.id,
          cert_number: slab.cert_number,
          grading_company: slab.grading_company.code,
          card_name: slab.card_name,
          grade: slab.grade,
          verified: slab.verified,
          population: {
            total: slab.population_total,
            higher: slab.population_higher,
            percentage: slab.population_percentage
          },
          scanned_at: slab.created_at
        }
      end
    end
  end
end
