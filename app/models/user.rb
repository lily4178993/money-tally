class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :expenses, foreign_key: :author_id, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, allow_blank: false, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, allow_blank: false
  validates :password, presence: true, allow_blank: false, length: { minimum: 6, maximum: 50 }

  before_save :set_default_profile_photo

  private

  def set_default_profile_photo
    self.profile_photo ||= 'images/default_profile_photo.svg'
  end
end
