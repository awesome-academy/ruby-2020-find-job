class Notification < ApplicationRecord
  after_commit :notification_relay
  
  belongs_to :creator, class_name: User.name, foreign_key: :creator_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id
  belongs_to :post

  validates :creator_id, :receiver_id, :data, :post_id, presence: true

  scope :not_view, -> {where viewed: false}

  private

  def notification_relay
    NotificationRelayJob.perform_now self
  end
end
