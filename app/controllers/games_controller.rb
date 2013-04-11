class GamesController < ApplicationController

  def new
    # session[:game_id] = nil
    # render :show
  end

  def create
    # uri = URI.parse('https://battle.platform45.com/register')
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Get.new(uri.request_uri)
    # response = http.request(request)
    # puts response.body

    session[:game] = nil

    redirect_to play_path
  end

  def show
  end

  def update
    unless current_game
      game = Game.create(user: current_user)
      game.update_attribute(:board_user, session[:board])
      session[:game] = game.id
    end

    result = current_game.fire!(params[:row].to_i, params[:cell].to_i)
    current_game.save
    redirect_to play_path
  end
end
