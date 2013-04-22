class Cell < ActiveRecord::Base
  attr_accessible :ship_id, :x, :y
  
  validates_presence_of :x, :y
end
