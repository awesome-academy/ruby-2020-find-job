class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform notification
    receiver_id = notification.receiver_id
    html = ApplicationController.render partial: "notifications/notification", locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications_channel_#{receiver_id}", html: html
  end
end
