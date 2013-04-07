class UsersController < ApplicationController
  def create
    user = User.find_or_create_by_email(params[:user])
    session[:email] = user.email

    redirect_to game_path
  end
end
