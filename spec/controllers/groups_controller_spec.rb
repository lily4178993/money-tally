require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user, confirmed_at: Time.now) }
  let(:group) { create(:group, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: group.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, params: { user_id: user.id, group_id: group.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'redirects to the groups index page' do
      post :create, params: { group: { name: 'Test Group', icon: 'Test Icon' } }
      expect(response).to redirect_to(groups_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the groups index page' do
      delete :destroy, params: { id: group.id }
      expect(response).to redirect_to(groups_path)
    end
  end
end
