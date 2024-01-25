require 'rails_helper'

RSpec.feature 'Group show view', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user, confirmed_at: Time.now) }
  let(:group) { create(:group, user:) }
  let(:expense) { create(:expense, author: user, amount: 100) }

  before do
    sign_in user
    group.expenses << expense
    visit group_path(group)
    puts "location: #{current_path}"
  end

  scenario 'User visits group details page' do
    expect(page).to have_css('.back-box a[href*="groups"] img.icon-small')
    expect(page).to have_content('Expenses')
    expect(page).to have_css('img.icon-normal')
    expect(page).to have_content(group.expenses.sum(:amount))

    expect(page).to have_content(expense.name)
    expect(page).to have_content(expense.amount)
    expect(page).to have_content(expense.created_at.strftime('%d %b %Y at %I:%M%p'))
    expect(page).to have_button('Destroy')

    expect(page).to have_content('Add a new expense')
  end

  scenario 'User visits group details page with no expenses' do
    group.expenses.delete_all
    visit group_path(group)
    expect(page).to have_content('Expenses')
    expect(page).to have_content('There is nothing here...')
    expect(page).to have_content('Add a new expense')
  end
end
