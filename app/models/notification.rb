class Notification < ApplicationRecord
  belongs_to :creator, class_name: User.name, foreign_key: :creator_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id

  validates :creator_id, :receiver_id, :data, presence: true
end
