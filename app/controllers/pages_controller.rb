class PagesController < ApplicationController
  def index
    redirect_to play_path if current_user
    @user = User.new
    @game_count = Game.count
  end

  def play
    redirect_to root_path unless current_user

    if current_game
      @game = current_game
    else
      @game = Game.new
      session[:board] = @game.board_user
    end

    @board_user = @game.board_user
    @board_comp = @game.board_comp
    @sunk_user = @game.board_user.sunk
    @sunk_comp = @game.board_comp.sunk
    @winner_user = @game.winner_user?
    @winner_comp = @game.winner_comp?
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
