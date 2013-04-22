class Board < ActiveRecord::Base
  attr_accessible :height, :width, :game_id, :user_id
  
  validates_presence_of :width, :height
  
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
    set = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell if cell.ship?
      end
    end
    set
  end

  def hits
    set = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell if cell.hit?
      end
    end
    set
  end

  def positive_targets
    set = []
    self.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        set << cell if cell.ship? && !cell.hit?
      end
    end
    set
  end

  def negative_targets
    set = []
    self.each_with_index do |row, row_i|
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
            if cell.cell < @board_size - 1
              target = self[cell.row][cell.cell + 1]
              set << target if !target.hit?
            end
            if cell.cell > 0
              target = self[cell.row][cell.cell - 1]
              set << target if !target.hit?
            end
          else
            if cell.row < @board_size - 1
              target = self[cell.row + 1][cell.cell]
              set << target if !target.hit?
            end
            if cell.row > 0
              target = self[cell.row - 1][cell.cell]
              set << target if !target.hit?
            end
          end
        end
      end
    else
      spaces_by_ship(ship).each do |cell|
        if cell.hit?
          if cell.row < @board_size - 1
            target = self[cell.row + 1][cell.cell]
            set << target if !target.hit?
          end
          if cell.row > 0
            target = self[cell.row - 1][cell.cell]
            set << target if !target.hit?
          end
          if cell.cell < @board_size - 1
            target = self[cell.row][cell.cell + 1]
            set << target if !target.hit?
          end
          if cell.cell > 0
            target = self[cell.row][cell.cell - 1]
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
    self.each_with_index do |row, row_i|
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
    ships.reject{ |ship| ship.sunk? }
  end

  def sunk
    ships.select{ |ship| ship.sunk? }
  end
end
