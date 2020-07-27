class Experience < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :profile
  
  validates :title, length: {maximum: Settings.validation.max_length}
  
end
