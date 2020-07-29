class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :by_created_at, ->{order created_at: :desc}
  scope :post_listed, -> (by_ids){where(id: by_ids)}
  scope :post_applies, -> (by_post_ids){ where(post_id: by_post_ids)}
end
