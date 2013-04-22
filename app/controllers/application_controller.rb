class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :auth

  private
  
  def auth
    redirect_to root_path unless current_user
  end

  def current_user
    return unless user_id = session[:id]
    @current_user ||= User.find(user_id)
  end

  def current_game
    return unless game_id = session[:game]
    @current_game ||= Game.find(game_id)
  end

  helper_method :current_user
end
