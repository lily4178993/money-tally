require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, password: 'old_password') }

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
        expect(user.profile_photo).to eq('default_profile_photo.svg')
      end
    end
  end

  describe '#update_with_password' do
    it 'updates the user attributes' do
      user.update_with_password(name: 'New Name', current_password: 'old_password')
      expect(user.reload.name).to eq('New Name')
    end

    it 'does not update the user attributes if current password is incorrect' do
      user.update_with_password(name: 'New Name', current_password: 'wrong_password')
      expect(user.reload.name).not_to eq('New Name')
    end
  end

  describe '#update_without_password' do
    it 'updates the user attributes without changing the password' do
      user.update_without_password(name: 'New Name')
      expect(user.reload.name).to eq('New Name')
      expect(user.valid_password?('old_password')).to be true
    end
  end
end
