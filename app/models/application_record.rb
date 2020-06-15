class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :by_created_at, ->{order created_at: :desc}
end
