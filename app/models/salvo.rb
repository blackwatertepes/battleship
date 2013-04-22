class Salvo < ActiveRecord::Base
  attr_accessible :board_id, :x, :y
  
  validates_presence_of :x, :y
end
