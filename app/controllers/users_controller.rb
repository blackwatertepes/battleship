class UsersController < ApplicationController
  skip_before_filter :auth, :create
  
  def create
    user = User.find_or_create_by_email(params[:user])
    session[:id] = user.id

    redirect_to play_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.attributes = params[:user]
    
    if user.save
      redirect_to play_path, :notice => "Name/Email Saved!"
    else
      redirect_to edit_user_path, :notice => "There was an error. Try again."
    end
  end
end
