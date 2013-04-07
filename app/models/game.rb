class Game < ActiveRecord::Base
  attr_accessible :board, :winner

  def board
    self.new_board unless @grid
    @grid
  end

  def new_board
    @grid = []
    Array.new(100).each_slice(10) do |slice|
      @grid << slice
    end
    self.add_boats
  end
  
  def add_boats
    [ {name: "Carrier", length: 5},
      {name: "Battleship", length: 4},
      {name: "Destroyer", length: 3},
      {name: "Submarine", length: 2},
      {name: "Submarine", length: 2},
      {name: "Patrol Boat", length: 1},
      {name: "Patrol Boat", length: 1}].shuffle.each do |boat|
        self.add_boat(boat)
      end
  end

  def add_boat(boat)
    boat[:boat] = Array.new(boat[:length])
    row_i, cell_i, dir = self.find_gaps(boat[:length]).sample
    
    boat[:length].times do |n|
      if dir == 'right'
        @grid[row_i][cell_i + n] = {boat: boat, n: n, dir: dir}
      else
        @grid[cell_i + n][row_i] = {boat: boat, n: n, dir: dir}
      end
    end
  end

  def find_gaps(width)
    gaps = []
    @grid.each_with_index do |row, row_i|
      len = 0
      row.each_with_index do |cell, cell_i|
        len += 1
        if cell == nil
          if len >= width
            gaps << [row_i, cell_i - width + 1, 'right']
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
        if cell == nil
          if len >= width
            gaps << [row_i, cell_i - width + 1, 'down']
          end
        else
          len = 0
        end
      end
    end
    gaps
  end
end
