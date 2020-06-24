module ApplicationHelper
  def status_profiles profile
    profile.public_cv? ? t("public") : t("private") 
  end

  def profile_avatar profile
    return if profile.image

    gravatar_image_tag(current_user.email.gsub("spam", "mdeering"))
  end
  
  def user_apply? post
    current_user.user_applies.post_applies(post).present?
  end

  def qualification_time qualification
    [I18n.l(qualification.start_time), I18n.l(qualification.end_time)].join(" - ")
  end
end
