require 'rails_helper'

RSpec.feature 'User profile view', type: :feature do
  include Warden::Test::Helpers

  let(:user) { create(:user, confirmed_at: Time.now) }

  before do
    sign_in user
    visit profile_path
  end

  scenario 'User views his profile' do
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.created_at.strftime('%d %b %Y'))
    expect(page).to have_content('Edit Profile')
  end
end
