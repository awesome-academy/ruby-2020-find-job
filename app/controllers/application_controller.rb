class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do
    flash[:warning] = t "authorized"
    redirect_back fallback_location: root_path
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end
  
  private

  def default_url_options
    {locale: I18n.locale}
  end
end
