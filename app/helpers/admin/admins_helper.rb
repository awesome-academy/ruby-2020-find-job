module Admin::AdminsHelper
  def custom_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      text = "<script>toastr.#{type}('#{message}')</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
