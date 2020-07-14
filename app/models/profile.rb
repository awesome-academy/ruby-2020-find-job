class Profile < ApplicationRecord
  PROFILE_PERMIT = [:position, :address, :email, :phone, :education, :avatar, :title,
                    qualifications_attributes: [:id, :title, :content, :start_time, :end_time, :_destroy], 
                    experiences_attributes: [:id, :title, :description, :_destroy],
                    profile_skills_attributes: [:id, :name, :point, :_destroy]].freeze
  VALID_EMAIL_REGEX = Settings.email_regex

  belongs_to :user
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :profile_skills, dependent: :destroy
  has_many :views, as: :viewable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :qualifications, dependent: :destroy
  has_many :user_apply, dependent: :destroy

  delegate :username, to: :user, prefix: true

  enum status: {private_cv: 0, public_cv: 1}
  has_one_attached :image

  validates :education, presence: true, length: {maximum: Settings.validation.max_length}
  validates :title, presence: true, length: {maximum: Settings.validation.max_length}
  validates :phone, presence: true, length: {maximum: Settings.profile.phone_length}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, length: {maximum: Settings.profile.email_length}
  validates :address, presence: true, length: {maximum: Settings.profile.address_length}

  accepts_nested_attributes_for :qualifications, :experiences, :profile_skills, allow_destroy: true
  
  scope :by_status, -> {where status: Profile.statuses[:public_cv]}
  scope :by_profiles, -> by_id {where(["user_id IN (?) and status = ?", by_id, Profile.statuses[:public_cv]])}

  def time
    [I18n.l(created_at), I18n.l(updated_at)].join(" - ")
  end
end
