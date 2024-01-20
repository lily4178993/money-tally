class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups.recent_groups.includes(:expenses)
    @total_expenses_by_group = @groups.map do |group|
      Expense.total_expenses_by_group(group)
    end
  end

  def show
    @group = Group.find(params[:id])
    @expenses = Expense.recent_expenses(@group)
    @total_expense_amount = Expense.total_expenses_by_group(@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      flash[:notice] = 'New group created!'
    else
      flash[:alert] = 'Something went wrong! Failed to create a new group!'
    end
    redirect_to user_groups_path(current_user)
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:notice] = 'Group deleted!'
    else
      flash[:alert] = 'Something went wrong! Failed to delete the group!'
    end
    redirect_to user_groups_path(current_user)
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
