class Ship < ActiveRecord::Base
  attr_accessible :board
  
  validates_presence_of :board
  
  belongs_to :board
  has_many :cells
  
  def injured?
    # hits > 0
  end

  def hits
    # @body.count(1)
  end

  def sunk?
    # hits == @length
  end
end
