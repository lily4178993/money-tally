class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @total_groups = Group.total_groups(current_user)
    @total_expenses = @user.expenses.total_expenses

    @total_expenses_by_group = @user.groups.includes(:expenses).to_h do |group|
      [group.name, Expense.total_expenses_by_group(group)]
    end

    @total_expenses_by_month = (1..12).to_h do |month|
      date = Date.new(Date.today.year, month)
      [Date::MONTHNAMES[month], Expense.total_expenses_by_month(date.beginning_of_month..date.end_of_month)]
    end

    @total_expenses_by_group_and_month = @user.groups.includes(:expenses).to_h do |group|
      [group.name, (1..12).to_h do |month|
        date = Date.new(Date.today.year, month)
        [Date::MONTHNAMES[month],
         Expense.total_expenses_by_group_and_month(group, date.beginning_of_month..date.end_of_month)]
      end]
    end
  end

  def edit
    @user = current_user
  end

  def update
    successfully_updated = if user_params[:change_password].present?
                             current_user.update_with_password(user_params)
                           else
                             current_user.update_without_password(user_params)
                           end

    if successfully_updated
      bypass_sign_in(current_user)
      flash[:notice] = 'Your account has been updated!'
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    current_user.destroy
    flash[:notice] = 'Your account has been deleted!'
    redirect_to root_path
  end

  private

  def user_params
    permitted_params = %i[profile_photo name email current_password]
    permitted_params += %i[change_password password password_confirmation] if params[:user][:change_password] == '1'
    params.require(:user).permit(permitted_params)
  end
end
