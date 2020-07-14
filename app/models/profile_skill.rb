class ProfileSkill < ApplicationRecord
  belongs_to :profile

  validates :point, numericality: {greater_than_or_equal_to: Settings.validation.point_greater_than, less_than_or_equal_to: Settings.validation.point_less_than}, length: {maximum: Settings.validation.point_length}, allow_nil: true
  validates :name, length: {maximum: Settings.validation.max_length}

  scope :by_id, -> by_titles {select(:profile_id).where("name IN (?)", by_titles).group(:profile_id)}
end
