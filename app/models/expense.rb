class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups

  validates :name, presence: true, allow_blank: false, length: { minimum: 3, maximum: 50 }
  validates :amount, presence: true, allow_blank: false, numericality: { greater_than: 0 }
  validates :author_id, presence: true, allow_blank: false

  def self.recent_expenses(group)
    group.expenses.includes(:author).order(created_at: :desc)
  end

  def self.total_expenses
    Expense.all.sum(:amount)
  end

  def self.total_expenses_by_group(group)
    group.expenses.sum(:amount)
  end

  def self.total_expenses_by_group_and_month(group, month)
    Expense.joins(:groups).where(groups: { id: group.id }, created_at: month).sum(:amount)
  end

  def self.total_expenses_by_month(month)
    Expense.where(created_at: month).sum(:amount)
  end
end
