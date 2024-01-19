require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:icon) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:expenses) }
  end

  describe 'class methods' do
    describe '.total_groups' do
      it 'returns the total number of groups' do
        create_list(:group, 3, user:)
        expect(Group.total_groups(user)).to eq(3)
      end
    end

    describe '.recent_groups' do
      it 'returns the groups in descending order of creation' do
        group1 = create(:group)
        group2 = create(:group)
        group3 = create(:group)
        expect(Group.recent_groups).to eq([group3, group2, group1])
      end
    end
  end
end
