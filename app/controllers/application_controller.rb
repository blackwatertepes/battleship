class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :auth

  private
  
  def auth
    redirect_to root_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  def current_game
    @current_game ||= Game.find(session[:game]) if session[:game]
  end

  helper_method :current_user
end
