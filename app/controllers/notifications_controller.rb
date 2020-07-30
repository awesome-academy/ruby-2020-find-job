class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.notifications.by_created_at.page(params[:page]).per Settings.notification_per_page
  end
end
