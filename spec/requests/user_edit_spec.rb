require 'rails_helper'

RSpec.describe "Edit User Information", type: :system do
  let(:user) { create(:user) }

  describe 'with invalid information' do
    it 'should not be successful' do
    end
  end
end
