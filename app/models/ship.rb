class Ship < ActiveRecord::Base
  attr_accessible :board
  attr_accessor :name, :length, :direction, :x, :y
  
  validates_presence_of :board
  
  belongs_to :board
  has_many :cells, dependent: :delete_all
  
  after_create :cellify
  
  def hit!(cell)
    cells[cell].hit!
  end
  
  def injured?
    hits > 0
  end

  def hits
    cells.select{|cell| cell.hit? }.length
  end

  def sunk?
    hits == length
  end
  
  def floating?
    hits < length
  end
  
  private
  
  def cellify
    length.times do |n|
      cells << Cell.new
    end
  end
end
