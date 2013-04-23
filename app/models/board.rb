class Board < ActiveRecord::Base
  attr_accessible :rows, :cells, :game, :user
  
  validates_presence_of :cells, :rows, :game, :user
  
  belongs_to :game
  belongs_to :user
  has_many :ships, dependent: :delete_all
  has_many :salvos, dependent: :delete_all
  
  after_initialize :gridify
  
  def add_ship!(ship)
    row_i, cell_i, dir = gaps(ship.length + 2).sample
    ship.x = cell_i
    ship.y = row_i
    ship.direction = dir
    add_ship(ship)
  end

  def fire!(row, cell)
    @grid[row][cell].hit!
  end
  
  def injured
    floating.select{|ship| ship.injured? }
  end

  def fleet
    set = []
    shiped_spaces.each do |space|
      set << space.ship unless set.include?(space.ship)
    end
    set
  end

  def spaces_by_ship(ship)
    shiped_spaces.select{|unit| unit.ship == ship }
  end

  def shiped_spaces
    set = []
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell if cell.ship?
      end
    end
    set
  end

  def hits
    set = []
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell if cell.hit?
      end
    end
    set
  end

  def positive_targets
    set = []
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell if cell.ship? && !cell.hit?
      end
    end
    set
  end

  def negative_targets
    set = []
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell unless cell.ship? || cell.hit?
      end
    end
    set
  end

  def neighbors(ship)
    set = []
    if ship.hits > 1
      spaces_by_ship(ship).each do |cell|
        if cell.hit?
          if cell.dir == 'right'
            if cell.cell < height - 1
              target = grid[cell.row][cell.cell + 1]
              set << target if !target.hit?
            end
            if cell.cell > 0
              target = grid[cell.row][cell.cell - 1]
              set << target if !target.hit?
            end
          else
            if cell.row < width - 1
              target = grid[cell.row + 1][cell.cell]
              set << target if !target.hit?
            end
            if cell.row > 0
              target = grid[cell.row - 1][cell.cell]
              set << target if !target.hit?
            end
          end
        end
      end
    else
      spaces_by_ship(ship).each do |cell|
        if cell.hit?
          if cell.row < height - 1
            target = grid[cell.row + 1][cell.cell]
            set << target if !target.hit?
          end
          if cell.row > 0
            target = grid[cell.row - 1][cell.cell]
            set << target if !target.hit?
          end
          if cell.cell < width - 1
            target = grid[cell.row][cell.cell + 1]
            set << target if !target.hit?
          end
          if cell.cell > 0
            target = grid[cell.row][cell.cell - 1]
            set << target if !target.hit?
          end
        end
      end
    end
    set
  end

  def targets
    unless injured.empty?
      return neighbors(injured.sample)
    else
      return unhit
    end
  end

  def unhit
    set = []
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell unless cell.hit?
      end
    end
    set
  end

  def clear?
    floating.length == 0
  end

  def floating
    fleet.reject{ |ship| ship.sunk? }
  end

  def sunk
    fleet.select{ |ship| ship.sunk? }
  end
  
  def gridify
    grid = @grid = []
    Array.new(10 * 10).each_slice(10) { |slice| grid << slice }
    grid.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        grid[row_i][cell_i] = Unit.new(cell_i, row_i)
      end
    end
    
    ships.each do |ship|
      add_ship(ship)
    end
    
    salvos.each do |salvo|
      add_salvo(salvo)
    end
  end
  
  private
  
  def add_ship(ship)
    ship.length.times do |cell|
      cell_index = ship.x
      row_index = ship.y
      
      if ship.direction == 'right'
        cell_index = ship.x + 1 + cell
      else
        row_index = ship.y + 1 + cell
      end
      
      unit = @grid[row_index][cell_index]
      unit.ship = ship
      unit.cell = cell
    end
  end
  
  def add_salvo(salvo)
    unit = grid[salvo.x][salvo.y]
    unit.hit!
  end

  def gaps(width)
    set = []
    @grid.each_with_index do |row, row_i|
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

    @grid.transpose.each_with_index do |row, row_i|
      len = 0
      row.each_with_index do |cell, cell_i|
        len += 1
        if !cell.ship?
          if len >= width
            set << [cell_i - width + 1, row_i, 'down']
          end
        else
          len = 0
        end
      end
    end
    set
  end
end

class Unit
  attr_accessor :cell, :row, :ship, :ship_cell, :hit

  def initialize(x, y)
    @cell = x
    @row = y
    @ship = nil
    @ship_cell = nil
    @hit = false
  end
  
  def add_cell!(_ship, _cell)
    @ship = _ship
    @ship_cell = _cell
  end

  def hit!
    if ship?
      @ship.cells[@ship_cell].hit!
    end
    
    @hit = true
  end

  def hit?
    return @hit
  end

  def ship?
    return true if @ship
    return false
  end
end