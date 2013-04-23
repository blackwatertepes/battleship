class Salvo < ActiveRecord::Base
  attr_accessible :board, :x, :y
  
  validates_presence_of :x, :y, :board
  
  belongs_to :board
  
end
