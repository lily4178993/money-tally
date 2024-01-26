require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @user = create(:user, confirmed_at: Time.now)
    sign_in @user
  end

  describe '#profile' do
    it 'returns http success' do
      get :profile
      expect(response).to be_successful
    end
  end

  describe '#statistics' do
    before do
      @group = create(:group, user: @user)
      @expense = create(:expense, author: @user, amount: 10)
      get :statistics
    end

    it 'returns http success' do
      expect(response).to be_successful
    end

    it 'assigns statistical data' do
      expect(assigns(:total_groups)).not_to be_nil
      expect(assigns(:total_expenses)).not_to be_nil
      expect(assigns(:total_expenses_by_group)).not_to be_nil
      expect(assigns(:total_expenses_by_month)).not_to be_nil
      expect(assigns(:total_expenses_by_group_and_month)).not_to be_nil
    end
  end
end
