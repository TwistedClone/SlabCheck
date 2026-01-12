require 'rails_helper'

RSpec.describe "Api::V1::Slabs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/slabs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/slabs/show"
      expect(response).to have_http_status(:success)
    end
  end

end
