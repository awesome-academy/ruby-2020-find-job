module ApplicationHelper
  def status_profiles profile
    profile.public_cv? ? t("public") : t("private") 
  end
  
  def user_apply? post
    current_user.user_applies.post_applies(post).present?
  end

  def qualification_time qualification
    return if qualification.start_time.blank?

    end_time = qualification.end_time || t("until_now")
    [l(qualification.start_time), end_time].join(" - ")
  end

  def applied_post_status post
    return if current_user.nil?
    apply_post = current_user.user_applies.find_by post_id: post
    apply_post.status_i18n if apply_post.present?
  end

  def chart_group_by_day_of_month provider 
    provider.group_by_day_of_month(:created_at).count
  end

  def count_not_viewed_notification 
    count = current_user.notifications.not_view.size
    return if count.blank?
    return Settings.max_notification.to_s + "+" if count >= Settings.max_notification
    count
  end

  def sort_notification current_user
    current_user.notifications.by_created_at
  end

  def custom_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error" if type == "danger"
      text = "<script>toastr.#{type}('#{message}')</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
