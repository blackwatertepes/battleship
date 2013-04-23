class Cell < ActiveRecord::Base
  attr_accessible :ship, :x, :y
  
  validates_presence_of :x, :y, :ship
  
  belongs_to :ship
  
  @hit = false
  
  def hit!
    @hit = true
  end
  
  def hit?
    @hit
  end
end
