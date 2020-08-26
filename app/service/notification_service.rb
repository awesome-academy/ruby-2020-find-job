class NotificationService
  def initialize current_user, user_apply
    @current_user = current_user
    @user_apply = user_apply
  end

  def push_notification
    data = Settings.notification_data
    notification = Notification.create creator_id: current_user.id, 
                                       receiver_id: user_apply.user_id, 
                                       data: data,
                                       post_id: user_apply.post_id
  end

  private

  attr_reader :current_user, :user_apply
end
