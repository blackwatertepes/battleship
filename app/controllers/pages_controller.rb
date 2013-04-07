class PagesController < ApplicationController
  def index
    redirect_to play_path if current_user
    @user = User.new
    @game_count = Game.count
  end

  def play
    redirect_to root_path unless current_user

    @game = Game.new
    @board = @game.board
  end

  def logout
    session[:email] = nil

    redirect_to root_path                                                                                                                                         
  end

  def proxy
    p params
    render :json => params
  end
end
