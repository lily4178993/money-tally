require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should_not allow_value('').for(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { should validate_presence_of(:email) }
    it { should_not allow_value('').for(:email) }
    it { should validate_presence_of(:password) }
    it { should_not allow_value('').for(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(50) }
  end

  describe 'associations' do
    it { should have_many(:expenses).dependent(:destroy) }
    it { should have_many(:groups).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe '#set_default_profile_photo' do
      let(:user) { create(:user) }

      it 'sets a default profile photo for the user' do
        expect(user.profile_photo).to be_present
      end
    end
  end
end
