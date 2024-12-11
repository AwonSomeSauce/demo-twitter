require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user.name = " "
      expect(user).not_to be_valid
    end

    it 'is invalid without an email' do
      user.email = " "
      expect(user).not_to be_valid
    end

    it 'is invalid without a password' do
      user.password = " "
      expect(user).not_to be_valid
    end

    it 'is invalid if name is too long' do
      user.name = 'a' * 51
      expect(user).not_to be_valid
    end

    it 'is invalid if email is too long' do
      user.email = 'a' * 244 + 'example.com'
      expect(user).not_to be_valid
    end

    it 'is invalid if password is too short' do
      user.password = 'a' * 5
      expect(user).not_to be_valid
    end

    it 'accepts valid email addresses' do
      valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org]
      valid_addresses.each do |address|
        user.email = address
        expect(user).to be_valid
      end
    end

    it 'rejects invalid email addresses' do
      invalid_addresses = %w[
        user@example,com
        USER_at_foo.com
        A_US-ER@foo.bar.org.
        foo@bar_baz.com foo@bar+baz.com
      ]

      invalid_addresses.each do |address|
        user.email = address
        expect(user).not_to be_valid
      end
    end

    it 'requires unique email addresses' do
      create(:user, email: user.email)
      expect(user).not_to be_valid
    end
  end

  describe 'authenticated?' do
    it 'returns false for a user without a digest' do
      expect(user.authenticated?(" ")).to be false
    end

    it 'returns false for a user with invalid remember token' do
      user.remember

      expect(user.authenticated?("random-digest")).to be false
    end

    it 'returns true for a user with valid remember token' do
      user.remember

      expect(user.authenticated?(user.remember_token)).to be true
    end
  end

  describe 'remember' do
    it 'sets a remember token and updates the remember_digest' do
      user.remember
      expect(user.remember_token).not_to be_nil
      expect(user.remember_digest).not_to be_nil

      digest = BCrypt::Password.new(user.remember_digest)
      expect(digest).to eq(user.remember_token)
    end
  end
end
