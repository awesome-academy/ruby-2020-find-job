class Skill < ApplicationRecord
  belongs_to :skillable, polymorphic: true

  scope :by_ids, -> by_ids {where("skillable_id IN (?)", by_ids)}
end
