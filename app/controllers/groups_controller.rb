class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show destroy]

  def index
    @groups = current_user.groups.recent_groups.includes(:expenses)
    @total_expenses_by_group = @groups.map do |group|
      Expense.total_expenses_by_group(group)
    end
  end

  def show
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
      redirect_to groups_path
    else
      flash[:alert] = 'Something went wrong! Failed to create a new group!'
      render :new
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = 'Group deleted!'
    else
      flash[:alert] = 'Something went wrong! Failed to delete the group!'
    end
    redirect_to groups_path
  end

  private

  def set_group
    @group = current_user.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
