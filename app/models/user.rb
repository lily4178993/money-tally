class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :expenses, foreign_key: :author_id, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, allow_blank: false, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, allow_blank: false
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }, if: :password_required?

  before_save :set_default_profile_photo

  attr_accessor :current_password, :password_confirmation

  private

  def set_default_profile_photo
    self.profile_photo ||= 'default_profile_photo.svg'
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
