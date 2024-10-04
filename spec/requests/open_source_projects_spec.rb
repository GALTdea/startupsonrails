require 'rails_helper'

RSpec.describe "OpenSourceProjects", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/open_source_projects/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/open_source_projects/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/open_source_projects/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/open_source_projects/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
