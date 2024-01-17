require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'After sign in' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end

    it 'redirects to the authenticated root path' do
      expect(subject.after_sign_in_path_for(subject.current_user)).to eq(authenticated_root_path)
    end
  end

  describe 'After sign out' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_out user
    end

    it 'redirects to the root path' do
      expect(subject.after_sign_out_path_for(subject.current_user)).to eq(root_path)
    end
  end
end
