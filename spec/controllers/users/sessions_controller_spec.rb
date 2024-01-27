require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  describe 'After sign in' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end

    it 'redirects to the authenticated root path' do
      expect(subject.after_sign_in_path_for(user)).to eq(authenticated_root_path)
    end
  end

  describe 'After sign out' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
      sign_out user
    end

    it 'redirects to the root path' do
      expect(subject.after_sign_out_path_for(user)).to eq(root_path)
    end
  end
end
