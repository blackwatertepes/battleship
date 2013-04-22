class Board < ActiveRecord::Base
  attr_accessible :height, :width, :game_id, :user_id
end
