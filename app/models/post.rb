class Post < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :category
  belongs_to :user
  has_many :skills, as: :skillable, dependent: :destroy
  has_many :user_applies, dependent: :destroy

  delegate :title, to: :category, prefix: true
  delegate :company_logo, :company_name, to: :user

  accepts_nested_attributes_for :skills, reject_if: :all_blank, allow_destroy: true

  enum target_type: {freelance: 0, parttime: 1, fulltime: 2}

  validates :title, presence: true, length: {minimum: Settings.validation.title_min, maximum: Settings.validation.title_max}
  validates :description, presence: true, length: {minimum: Settings.validation.description_min, maximum: Settings.validation.description_max}
  validates :salary, presence: true, length: {minimum: Settings.validation.salary_min}
  validates :address, presence: true, length: {minimum: Settings.validation.address_min, maximum: Settings.validation.address_max}
  validates :target_type, :start_date, :end_date, presence: true

  POST_PARAMS = [:category_id, :title, :description, :salary, :address,
                 :target_type, :start_date, :end_date,
                 skills_attributes: [:id, :title, :_destroy]].freeze
  
  def apply_time
    [start_date, end_date].join(" - ")
  end

  def target_type_i18n
    I18n.t("enums.post.target_type.#{target_type}")
  end
end
