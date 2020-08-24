class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform notification
    return if User.find_by(id: notification.receiver_id).blank?
    
    receiver_id = notification.receiver_id
    count_not_viewes_noti = User.find_by(id: receiver_id).notifications.not_view.size
    html = ApplicationController.render partial: "shared/notification", locals: {notification: notification}, formats: [:html]
    
    count_not_viewes_noti >= Settings.max_notification ? count_not_viewes_noti = Settings.max_notification.to_s+"+" : count_not_viewes_noti

    ActionCable.server.broadcast "notifications_channel_#{receiver_id}", html: html
    ActionCable.server.broadcast "notifications_channel_#{receiver_id}", count_not_viewes_noti: count_not_viewes_noti
  end
end
