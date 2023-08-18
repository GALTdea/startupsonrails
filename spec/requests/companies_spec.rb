require 'rails_helper'

RSpec.describe "Companies", type: :request do
  let(:user) { create(:user) }
  let(:admin){ create(:admin)}
  let(:company) { create(:company) }
   
  
  describe "GET /index" do
    it "returns http success" do
      get "/companies/index"
      expect(response).to have_http_status(:success)
    end
  end



  
  describe "GET /show" do

    it "returns http success" do
     company = create(:company)
      get "/companies/#{company.id}}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
    
      get "/companies/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/companies/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
