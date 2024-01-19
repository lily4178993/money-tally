class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :expenses, foreign_key: :author_id, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, allow_blank: false, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, allow_blank: false
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }, if: :password_required?
  validates :password, confirmation: true, if: :password_confirmation
  validates :current_password, presence: true, if: :change_password?

  before_save :set_default_profile_photo

  attr_accessor :current_password, :change_password, :password_confirmation

  def change_password?
    change_password == '1'
  end

  def update_with_password(params, *options)
    update(params, *options)
  end

  def update_without_password(params, *options)
    params.delete(:password)
    params.delete(:password_confirmation)
    params.delete(:current_password)

    result = update(params, *options)
    clean_up_passwords
    result
  end

  private

  def set_default_profile_photo
    self.profile_photo ||= 'images/default_profile_photo.svg'
  end

  def password_required?
    !persisted? || !password.nil? || change_password? || !password_confirmation.nil?
  end
end
