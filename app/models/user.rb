class User < ApplicationRecord
  PASSWORD_REGEX = Settings.password_regex
  devise :database_authenticatable, :registerable, :validatable, :recoverable
  
  has_one :company, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :user_applies

  delegate :name, :logo, to: :company, prefix: true

  validates :username, presence: true, length: {maximum: Settings.validation.max_length}
  validate :password_complexity

  enum role: {user: 1, admin: 2}

  private

  def password_complexity
    if password.present? and not password.match(PASSWORD_REGEX)
      errors.add :password, I18n.t("errors.password_regex")
    end
  end
end
