class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.by_created_at.page(params[:page]).per Settings.notification_per_page
  end

  def update
    notification = Notification.find_by id: params[:id]
    return if notification.blank?
    
    notification.update viewed: true
    redirect_to post_path notification.post_id
  end
end
