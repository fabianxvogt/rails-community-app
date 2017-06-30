class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper

  # Managing the Locale across Requests
  def set_locale
    I18n.locale = current_user.try(:locale) || try {cookies.permanent[:locale]} || try {http_accept_language.preferred_language_from(I18n.available_locales)} || I18n.default_locale
  end

  private
  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Include the locale params in every URL
  def default_url_options
    {locale: I18n.locale}
  end
end
