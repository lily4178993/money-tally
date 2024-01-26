require 'rails_helper'

RSpec.feature 'Expense new view', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user, confirmed_at: Time.now) }
  let(:group) { create(:group, user:) }

  before do
    sign_in user
    visit new_group_expense_path(group)
  end

  scenario 'User creates a new expense' do
    fill_in 'Expense Name', with: 'Expense 1'
    fill_in 'Amount in $USD', with: 100
    click_button('Create')

    expect(page).to have_content('New expense created!')
  end

  scenario 'User creates a new expense with invalid data' do
    fill_in 'Expense Name', with: ''
    fill_in 'Amount in $USD', with: 100
    click_button('Create')

    expect(page).to have_content('Something went wrong! Failed to create a new expense!')
  end
end
