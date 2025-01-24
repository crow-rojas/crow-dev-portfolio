class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    # Try to get locale from parameters, then from session, then from Accept-Language header
    parsed_locale = params[:locale] || session[:locale] || request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}/)&.first
    if I18n.available_locales.map(&:to_s).include?(parsed_locale)
      parsed_locale
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
