require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:group) { create(:group, user:) }
  let(:expense) { create(:expense, author: user, groups: [group]) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'redirects to the correct path' do
      get :new, params: { user_id: user.id, group_id: group.id }
      expect(response).to be_redirect
    end
  end

  describe 'POST #create' do
    it 'redirects to the correct path' do
      post :create, params: { user_id: user.id, group_id: group.id }
      expect(response).to be_redirect
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the correct path' do
      delete :destroy, params: { user_id: user.id, group_id: group.id, id: expense.id }
      expect(response).to be_redirect
    end
  end
end
