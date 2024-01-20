require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:group) { create(:group, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'redirects to the correct path' do
      get :index, params: { user_id: user.id }
      expect(response).to be_redirect
    end
  end

  describe 'GET #show' do
    it 'redirects to the correct path' do
      get :show, params: { user_id: user.id, id: group.id }
      expect(response).to be_redirect
    end
  end

  describe 'GET #new' do
    it 'redirects to the correct path' do
      get :new, params: { user_id: user.id, group_id: group.id }
      expect(response).to be_redirect
    end
  end

  describe 'POST #create' do
    it 'redirects to the correct path' do
      get :create, params: { user_id: user.id, group_id: group.id }
      expect(response).to be_redirect
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the correct path' do
      delete :destroy, params: { user_id: user.id, id: group.id }
      expect(response).to be_redirect
    end
  end
end
