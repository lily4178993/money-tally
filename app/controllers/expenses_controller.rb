class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def new
    @expense = Expense.new
  end

  def create
    @expense = @group.expenses.build(expense_params)
    @expense.author_id = current_user.id
    @expense.groups << @group
    if @expense.save
      flash[:notice] = 'New expense created!'
    else
      flash[:alert] = 'Something went wrong! Failed to create a new expense!'
    end
    redirect_to group_path(@group)
  end

  def destroy
    @expense = @group.expenses.find(params[:id])
    if @expense.destroy
      flash[:notice] = 'Expense deleted!'
    else
      flash[:alert] = 'Something went wrong! Failed to delete the expense!'
    end
    redirect_to group_path(@group)
  end

  private

  def set_group
    @group = current_user.groups.find(params[:group_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
