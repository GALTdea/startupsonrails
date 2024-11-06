require 'rails_helper'

RSpec.describe "ProjectSupports", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/project_supports/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/project_supports/create"
      expect(response).to have_http_status(:success)
    end
  end

end
