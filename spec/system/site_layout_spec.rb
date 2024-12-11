require 'rails_helper'

RSpec.describe "Site Layout", type: :system do
  describe 'layout links' do
    it 'has the correct links on the home page' do
      visit root_path

      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_link("Help", href: help_path)
      expect(page).to have_link("About Us", href: about_path)
      expect(page).to have_link("Contact", href: contact_path)
    end
  end
end
