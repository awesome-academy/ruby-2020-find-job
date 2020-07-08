class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :by_created_at, ->{order created_at: :desc}
  scope :post_listed, -> (post_ids){where(id: post_ids)}
end
