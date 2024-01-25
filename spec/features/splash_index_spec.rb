require 'rails_helper'

RSpec.feature 'Splash index view', type: :feature do
  scenario 'User views the splash screen' do
    visit root_path
    expect(page).to have_content('MoneyTally')
    expect(page).to have_content('Log in')
    expect(page).to have_content('Sign up')
  end
end
