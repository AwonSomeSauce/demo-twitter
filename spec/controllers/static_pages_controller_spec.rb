require 'rails_helper'

RSpec.describe StaticPagesController, type: :request do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe 'GET/' do
    it 'returns a successful response and a correct title for home' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<title>#{base_title}</title>")
    end

    it 'returns a successful response and a correct title for help' do
      get help_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<title>Help | #{base_title}</title>")
    end

    it 'returns a successful response and a correct title for about' do
      get about_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<title>About | #{base_title}</title>")
    end

    it 'returns a successful response and a correct title for contact' do
      get contact_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<title>Contact | #{base_title}</title>")
    end
  end
end
