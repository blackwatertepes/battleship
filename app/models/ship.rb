class Ship < ActiveRecord::Base
  attr_accessible :board_id
  
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
