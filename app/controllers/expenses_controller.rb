class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.find(params[:group_id])
    @expense = Expense.new
  end

  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.author_id = current_user.id
    @expense.groups << @group
    if @expense.save
      flash[:notice] = 'New expense created!'
      redirect_to user_group_path(current_user, @group)
    else
      flash[:alert] = 'Something went wrong! Failed to create a new expense!'
      redirect_to user_group_path(current_user, @group)
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @expense = Expense.find(params[:id])
    if @expense.destroy
      flash[:notice] = 'Expense deleted!'
      redirect_to user_group_path(current_user, @group)
    else
      flash[:alert] = 'Something went wrong! Failed to delete the expense!'
      redirect_to user_group_path(current_user, @group)
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
