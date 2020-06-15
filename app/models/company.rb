class Company < ApplicationRecord
  belongs_to :user
  has_many :views, as: :viewable, dependent: :destroy

  validates :name, :phone, :address, presence: true
  validates :email, presence: true, format: {with: Settings.VALID_EMAIL_REGEX}
  validates :description, presence: true, length: {minimum: Settings.validation.description_min, maximum: Settings.validation.description_max}

  COMPANY_PARAMS = [:name, :email, :phone, :address, :description].freeze
end
