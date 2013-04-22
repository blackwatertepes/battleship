class PagesController < ApplicationController
  skip_before_filter :auth, only: :index
  
  def index
    redirect_to play_path if current_user
    
    @user = User.new
    @game_count = Game.count
  end

  def play
    if current_game
      @game = current_game
    else
      @game = Game.new
      session[:board] = Marshal::dump(@game.board_user)
    end

    @board_user = @game.board_user
    @board_comp = @game.board_comp
    @sunk_user = @game.board_user.sunk.map{|ship| ship.name }
    @sunk_comp = @game.board_comp.sunk.map{|ship| ship.name }
    @win_message = @game.win_message
  end

  def logout
    session[:id] = nil

    redirect_to root_path                                                                                                                                         
  end
end
