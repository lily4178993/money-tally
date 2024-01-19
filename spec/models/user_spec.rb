require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should_not allow_value('').for(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { should validate_presence_of(:email) }
    it { should_not allow_value('').for(:email) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(30) }
  end

  describe 'associations' do
    it { should have_many(:expenses).dependent(:destroy) }
    it { should have_many(:groups).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe '#set_default_profile_photo' do
      it 'sets a default profile photo for the user' do
        expect(user.profile_photo).to eq('images/default_profile_photo.png')
      end
    end
  end

  describe '#change_password?' do
    it 'returns true when change_password is "1"' do
      user.change_password = '1'
      expect(user.change_password?).to be true
    end

    it 'returns false when change_password is not "1"' do
      user.change_password = '0'
      expect(user.change_password?).to be false
    end
  end

  describe '#update_with_password' do
    it 'updates the user attributes' do
      user.update_with_password(name: 'New Name')
      expect(user.name).to eq('New Name')
    end
  end

  describe '#update_without_password' do
    it 'updates the user attributes without changing the password' do
      user.update_without_password(name: 'New Name')
      expect(user.name).to eq('New Name')
      expect(user.encrypted_password).to be_present
    end
  end
end
