class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def statistics
    puts "Current user: #{current_user.inspect}"
    @user = current_user
    @total_groups = Group.total_groups(current_user)
    @total_expenses = Expense.total_expenses(current_user)

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
end
