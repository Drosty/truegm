class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  layout :layout_by_resource

  helper_method :current_week

  before_filter :configure_devise_params, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :name)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :name, :current_password)
    end
  end

  def after_sign_in_path_for(resource)
    "/#/leagues"
  end

  def current_week
    Rails.cache.fetch(:current_week, expires_in: 4.hours) do
      party = FantasyFootballNerdParty.new(ENV['ffn_api_key'])
      party.current_week
    end
  end

private

  def layout_by_resource
    if devise_controller? || controller_name == "welcome"
      return "nong"
    else
      return "application"
    end
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this."
    head :unauthorized
    redirect_to(request.referrer || leagues_path)
  end

  def ensure_user_logged_in
    if current_user.nil?
      flash[:error] = "Must be logged in."
      redirect_to(request.referrer || new_user_session_path)
    end
  end

end
