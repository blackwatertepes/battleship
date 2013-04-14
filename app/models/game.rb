class Game < ActiveRecord::Base
  attr_accessible :user

  serialize :board_user
  serialize :board_comp

  validates_presence_of :user

  belongs_to :user

  after_initialize :new_boards

  def new_boards
    self.board_user = new_board unless board_user && board_user.length > 0
    self.board_comp = new_board unless board_comp && board_comp.length > 0
  end

  def new_board
    board = Board.new
    Array.new(100).map{|n| Unit.new }.each_slice(10) { |slice| board << slice }
    self.add_ships!(board)
  end
  
  def add_ships!(board)
    [ Ship.new("Carrier", 5),
      Ship.new("Battleship", 4),
      Ship.new("Destroyer", 3),
      Ship.new("Submarine 1", 2),
      Ship.new("Submarine 2", 2),
      Ship.new("Patrol Boat 1", 1),
      Ship.new("Patrol Boat 2", 1)].shuffle.each do |ship|
        self.add_ship!(ship, board)
      end
    board
  end

  def add_ship!(ship, board)
    row_i, cell_i, dir = gaps(ship.length + 2, board).sample
    
    ship.length.times do |n|
      cell_index = cell_i + 1 + n
      unit = Unit.new({ship: ship, n: n, dir: dir, cell: cell_index, row: row_i})
      if dir == 'right'
        board[row_i][cell_index] = unit
      else
        board[cell_index][row_i] = unit
      end
    end
  end

  def gaps(width, board)
    set = []
    board.each_with_index do |row, row_i|
      len = 0
      row.each_with_index do |cell, cell_i|
        len += 1
        if !cell.ship?
          if len >= width
            set << [row_i, cell_i - width + 1, 'right']
          end
        else
          len = 0
        end
      end
    end

    board.transpose.each_with_index do |row, row_i|
      len = 0
      row.each_with_index do |cell, cell_i|
        len += 1
        if !cell.ship?
          if len >= width
            set << [row_i, cell_i - width + 1, 'down']
          end
        else
          len = 0
        end
      end
    end
    set
  end

  def fire!(row, cell)
    self.board_comp[row][cell].hit!
    volley!
  end

  def volley!
    target = board_user.targets.sample
    cell = self.board_user[target[0]][target[1]]
    cell.hit!
  end

  def winner_user?
    self.board_comp.clear?
  end

  def winner_comp?
    self.board_user.clear?
  end
end

class Board < Array
  def injured
    floating.select{|ship| ship.injured? }
  end

  def ships
    fleet = []
    shiped_spaces.each do |space|
      fleet << space.ship unless fleet.include?(space.ship)
    end
    fleet
  end

  def spaces_by_ship(ship)
    shiped_spaces.select{|unit| unit.ship == ship }
  end

  def shiped_spaces
    targets = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        targets << cell if cell.ship?
      end
    end
    targets
  end

  def hits
    set = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << [row_i, cell_i] if cell.hit?
      end
    end
    set
  end

  def positive_targets
    targets = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        targets << [row_i, cell_i] if cell.ship? && !cell.hit?
      end
    end
    targets
  end

  def negative_targets
    targets = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        targets << [row_i, cell_i] unless cell.ship? || cell.hit?
      end
    end
    targets
  end

  def targets
    set = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << [row_i, cell_i] unless cell.hit?
      end
    end
    set
  end

  def clear?
    floating.length == 0
  end

  def floating
    ships.reject{ |ship| sunk?(ship) }
  end

  def sunk
    ships.select{ |ship| sunk?(ship) }
  end

  def sunk?(ship)
    !ship.body.include?(nil)
  end

  def boat?(item)
    item.class == Unit
  end
end

class Unit
  attr_reader :ship, :n, :dir, :cell, :row

  def initialize(params = nil)
    if params
      @ship = params[:ship]
      @n = params[:n]
      @dir = params[:dir]
      @cell = params[:cell]
      @row = params[:row]
    end
  end

  def hit!
    if ship?
      @ship.body[@n] = 1
    else
      @ship = 1
    end
  end

  def hit?
    return @ship.body[@n] == 1 if ship?
    return @ship == 1
  end

  def ship?
    @ship.class == Ship
  end
end

class Ship
  attr_reader :name, :length
  attr_accessor :body

  def initialize(name, length)
    @name = name
    @length = length
    @body = Array.new(length)
  end

  def injured?
    @body.include?(1)
  end
end
