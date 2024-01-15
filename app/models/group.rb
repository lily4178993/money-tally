class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses

  validates :name, presence: true, allow_blank: false, length: { minimum: 3, maximum: 50 }
  validates :user_id, presence: true, allow_blank: false
  validates :icon, presence: true, allow_blank: false

  def self.total_groups
    Group.all.count(:id)
  end
end
