class User < ApplicationRecord
  acts_as_paranoid
  
  PASSWORD_REGEX = Settings.password_regex
  devise :database_authenticatable, :registerable, :confirmable, :async, :validatable, :recoverable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  
  has_one :company, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :notifications, foreign_key: :receiver_id, dependent: :destroy
  has_many :sender, foreign_key: :creator_id, dependent: :destroy
  has_many :views, dependent: :destroy
  has_many :user_applies
  has_many :comments, dependent: :destroy

  delegate :name, :logo, to: :company, prefix: true

  validates :username, presence: true, length: {maximum: Settings.validation.max_length}
  validate :password_complexity
  
  enum role: {user: 1, admin: 2}

  class << self
    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  
    def from_omniauth access_token
      data = access_token.info
      result = User.find_by email: data.email
      if result
        return result
      else
        password = Devise.friendly_token[0,20]
        where(provider: access_token.provider, uid: access_token.uid).first_or_create do |user|
          user.email = data.email
          user.password = password
          user.password_confirmation = password
          user.username = data.name
          user.confirmation_sent_at = Time.zone.now
          user.confirmed_at = Time.zone.now
        end
      end
    end
  end

  private

  def password_complexity
    if password.present? and not password.match(PASSWORD_REGEX)
      errors.add :password, I18n.t("errors.password_regex")
    end
  end
end
