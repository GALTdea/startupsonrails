# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  username               :string
#  user_type              :string
#  admin?                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'Devise authentication' do
    let(:user) { create(:user) }

    describe 'valid attributes' do
      it 'is valid with valid attributes' do
        expect(user).to be_valid
      end

      it 'is not valid without an email' do
        user.email = nil
        expect(user).not_to be_valid
      end

      it 'is not valid without a password' do
        user.password = nil
        expect(user).not_to be_valid
      end

      it 'is not valid with a duplicate email' do
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end
    end

    describe 'sign in' do
      it 'can sign in with valid credentials' do
        expect(user.valid_password?(user.password)).to be_truthy
      end

      it 'cannot sign in with invalid credentials' do
        expect(user.valid_password?('invalid_password')).to be_falsey
      end
    end
  end
end
