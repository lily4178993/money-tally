require 'rails_helper'

RSpec.feature 'User statistics view', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user, confirmed_at: Time.now) }
  let(:group) { create(:group, user:) }
  let(:expenses_list) { create_list(:expense, 5, author: user, amount: 100.22) }

  before do
    sign_in user
    group.expenses << expenses_list
    visit statistics_path
  end

  scenario 'User views his statistics with data' do
    expect(page).to have_content('Statistics')
    expect(page).to have_content("Total Categories created: #{user.groups.count}")
    expect(page).to have_content("Total Expenses: $#{user.expenses.sum(:amount)}")
    expect(page).to have_content('Total Expenses by Category:')
    expect(page).to have_content('Total Expenses by Month:')
  end

  scenario 'User views his statistics with no data' do
    user.expenses.delete_all
    user.groups.delete_all
    visit statistics_path
    expect(page).to have_content('Statistics')
    expect(page).to have_content('Total Categories created: 0')
    expect(page).to have_content('Total Expenses: $0.0')
    expect(page).to have_content('Total Expenses by Category:')
    expect(page).to have_content('Total Expenses by Month:')
  end
end
