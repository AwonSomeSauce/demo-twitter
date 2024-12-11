require "rails_helper"

RSpec.describe SessionsController, type: :request do
  describe "GET /login" do
    it "returns a successful response" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
