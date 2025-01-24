class LocalesController < ApplicationController
  def update
    locale = params[:locale].to_s.strip.to_sym
    if I18n.available_locales.include?(locale)
      session[:locale] = locale
      I18n.locale = locale

      # Try to redirect to the same page with new locale
      if request.referer.present?
        # Parse the previous URL and update its locale
        uri = URI(request.referer)
        path_segments = uri.path.split("/")

        if path_segments[1] && I18n.available_locales.map(&:to_s).include?(path_segments[1])
          # If URL already has a locale, replace it
          path_segments[1] = locale.to_s
        else
          # If URL doesn't have a locale, add it after the first slash
          path_segments.insert(1, locale.to_s)
        end

        redirect_to path_segments.join("/"), allow_other_host: false
      else
        redirect_to root_path(locale: locale)
      end
    else
      redirect_to root_path
    end
  end
end
