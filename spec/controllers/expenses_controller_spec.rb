require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user, confirmed_at: Time.now) }
  let(:group) { create(:group, user:) }
  let(:expense) { create(:expense, author: user, groups: [group]) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, params: { group_id: group.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'redirects to the group show page' do
      post :create, params: { group_id: group.id, expense: { name: 'Test Expense', amount: 10 } }
      expect(response).to redirect_to(group_path(group))
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the group show page' do
      delete :destroy, params: { group_id: group.id, id: expense.id }
      expect(response).to redirect_to(group_path(group))
    end
  end
end
