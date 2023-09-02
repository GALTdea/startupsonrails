# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  url        :string
#  about      :text
#  email      :string
#  location   :string
#  links      :string
#  tech_stack :text
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
require 'rails_helper'

RSpec.describe Company, type: :model do
   let(:user) { FactoryBot.create(:user) }
   let(:company) { FactoryBot.create(:company) }

   context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }
   end
end
