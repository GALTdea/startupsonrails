require 'rails_helper'

RSpec.describe "Issues", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/issues/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/issues/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/issues/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
