require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:author_id) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_and_belong_to_many(:groups) }
  end

  describe 'class methods' do
    describe '.total_expenses' do
      it 'returns the total number of expenses' do
        user = create(:user)
        create_list(:expense, 3, author: user, amount: 10)
        expect(Expense.total_expenses(user)).to eq(30)
      end
    end

    describe '.total_expenses_by_group' do
      it 'returns the total number of expenses by group' do
        group = create(:group)
        create_list(:expense, 3, amount: 1, groups: [group])
        expect(Expense.total_expenses_by_group(group)).to eq(3)
      end
    end

    describe '.total_expenses_by_group_and_month' do
      it 'returns the total number of expenses by group and month' do
        group = create(:group)
        create_list(:expense, 3, amount: 1, groups: [group], created_at: Time.zone.now.beginning_of_month)
        expect(Expense.total_expenses_by_group_and_month(group,
                                                         Time.zone.now.beginning_of_month..Time.zone.now.end_of_month))
          .to eq(3)
      end
    end

    describe '.total_expenses_by_month' do
      it 'returns the total number of expenses by month' do
        create_list(:expense, 3, amount: 1, created_at: Time.zone.now.beginning_of_month)
        expect(Expense.total_expenses_by_month(Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)).to eq(3)
      end
    end
  end
end
