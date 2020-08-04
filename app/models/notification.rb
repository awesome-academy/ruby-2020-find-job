class Notification < ApplicationRecord
  after_commit :notification_relay
  
  belongs_to :creator, class_name: User.name, foreign_key: :creator_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id

  validates :creator_id, :receiver_id, :data, presence: true

  private

  def notification_relay
    NotificationRelayJob.perform_later(self)
  end
end
