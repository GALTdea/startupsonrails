require 'rails_helper'

RSpec.describe "Contributions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/contributions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
