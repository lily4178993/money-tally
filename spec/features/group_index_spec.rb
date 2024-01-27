require 'rails_helper'

RSpec.feature 'Group index view', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user, confirmed_at: Time.now) }
  let!(:group1) { create(:group, user:, name: 'Category 1', icon: 'g/gi1.svg') }

  before do
    sign_in user
    visit groups_path
  end

  scenario 'User views groups index page' do
    expect(page).to have_css('.title', text: 'Categories')
    expect(page).to have_css('.box-buttons-actions a.add-button', text: 'Add a new category')
    expect(page).to have_css('.categories li.category', count: 1)
    within('.categories li.category:last-child') do
      expect(page).to have_css('.card img.icon-large')
      expect(page).to have_css('.card h2.title', text: 'Category 1')
      expect(page).to have_css('.card p.creation-date', text: group1.created_at.strftime('%d %b %Y'))
      expect(page).to have_css('.card-price', text: "$#{group1.expenses.sum(:amount)}")
      expect(page).to have_button('Delete')
    end
  end

  scenario 'User views empty groups index page' do
    Group.destroy_all # Remove existing groups
    visit groups_path
    expect(page).to have_css('.empty-message', text: 'No categories')
    expect(page).to have_css('.box-buttons-actions a.add-button', text: 'Add a new category')
  end

  scenario 'User deletes a group' do
    visit groups_path

    click_button('Delete')

    expect(page).to have_content('Group deleted!')
  end
end
