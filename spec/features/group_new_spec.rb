require 'rails_helper'

RSpec.feature 'Group new view', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user, confirmed_at: Time.now) }

  before do
    sign_in user
    visit new_group_path
  end

  scenario 'User creates a new group' do
    fill_in 'Category Name', with: 'Category 1'
    choose('group_icon_ggi14_svg')
    click_button('Create')

    expect(page).to have_content('New group created!')
  end

  scenario 'User creates a new group with invalid data' do
    fill_in 'Category Name', with: ''
    choose('group_icon_ggi14_svg')
    click_button('Create')

    expect(page).to have_content('Something went wrong! Failed to create a new group!')
  end
end
