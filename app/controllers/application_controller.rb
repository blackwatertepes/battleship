class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find_by_email(session[:email]) if session[:email]
  end

  helper_method :current_user
end
