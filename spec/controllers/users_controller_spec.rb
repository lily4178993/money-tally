require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'redirects to the correct path' do
      get :show, params: { id: user.id }
      expect(response).to be_redirect
    end
  end

  describe 'GET #edit' do
    it 'redirects to the correct path' do
      get :edit, params: { id: user.id }
      expect(response).to be_redirect
    end
  end

  describe 'PATCH #update' do
    it 'redirects to the correct path' do
      patch :update, params: { id: user.id }
      expect(response).to be_redirect
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the correct path' do
      delete :destroy, params: { id: user.id }
      expect(response).to be_redirect
    end
  end
end
