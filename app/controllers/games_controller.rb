require 'net/https'
require 'uri'

class GamesController < ApplicationController

  def new
    # session[:game_id] = nil
    # render :show
  end

  def create
    uri = URI.parse('https://battle.platform45.com/register')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    puts response.body

    redirect_to play_path
  end

  def show
  end
end
