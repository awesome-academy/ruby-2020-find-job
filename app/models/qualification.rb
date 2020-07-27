class Qualification < ApplicationRecord
  acts_as_paranoid

  belongs_to :profile

  validate :qualification_start_time_invalid
  validates :title, length: {maximum: Settings.validation.max_length}

  def qualification_time
    [start_time, end_time].join(" - ")
  end

  private 

  def qualification_start_time_invalid
    return if start_time.nil? || start_time < Date.today
    errors.add(:start_time, I18n.t("cv.start_time"))
  end
end  
