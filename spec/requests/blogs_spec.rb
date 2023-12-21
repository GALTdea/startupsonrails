require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/blogs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/blogs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/blogs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/blogs/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
