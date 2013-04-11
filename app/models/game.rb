class Game < ActiveRecord::Base
  attr_accessible :user

  serialize :board_user
  serialize :board_comp

  belongs_to :user

  after_initialize :new_boards

  def new_boards
    self.board_user = new_board unless self.board_user
    self.board_comp = new_board unless self.board_comp
  end

  def new_board
    board = []
    Array.new(100).each_slice(10) do |slice|
      board << slice
    end
    self.add_boats(board)
    board
  end
  
  def add_boats(board)
    [ {name: "Carrier", length: 5},
      {name: "Battleship", length: 4},
      {name: "Destroyer", length: 3},
      {name: "Submarine 1", length: 2},
      {name: "Submarine 2", length: 2},
      {name: "Patrol Boat 1", length: 1},
      {name: "Patrol Boat 2", length: 1}].shuffle.each do |boat|
        self.add_boat(boat, board)
      end
  end

  def add_boat(boat, board)
    boat[:boat] = Array.new(boat[:length])
    row_i, cell_i, dir = self.find_gaps(boat[:length] + 2, board).sample
    
    boat[:length].times do |n|
      if dir == 'right'
        board[row_i][cell_i + 1 + n] = {boat: boat, n: n, dir: dir}
      else
        board[cell_i + 1 + n][row_i] = {boat: boat, n: n, dir: dir}
      end
    end
  end

  def find_gaps(width, board)
    gaps = []
    board.each_with_index do |row, row_i|
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

    board.transpose.each_with_index do |row, row_i|
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

  def fire!(row, cell)
    item = self.board_comp[row][cell]
    if item && item.class == Hash
      item[:boat][:boat][item[:n]] = 1
      # self.board_comp[row][cell] = item
    else
      self.board_comp[row][cell] = 0
    end

    volley!
  end

  def volley!
    target = find_targets(self.board_user).sample
    cell = self.board_user[target[0]][target[1]]
    if cell && cell.class == Hash
      cell[:boat][:boat][cell[:n]] = 1
    else
      self.board_user[target[0]][target[1]] = 0
    end
  end

  def find_targets(board)
    targets = []
    board.each_with_index do |row, row_i|
      row.each_with_index do |cell, cell_i|
        targets << [row_i, cell_i] unless cell == 0 || cell == 1
      end
    end
    targets
  end

  def sunk_user
    Hash[*sunk(self.board_user).map{|boat| [boat[:name], boat] }.flatten]
  end

  def sunk_comp
    Hash[*sunk(self.board_comp).map{|boat| [boat[:name], boat] }.flatten]
  end

  def sunk(board)
    sunk = []
    board.each do |row|
      row.each do |cell|
        if cell.class == Hash && cell[:boat] && !cell[:boat][:boat].include?(nil) && !sunk.include?(cell[:boat])
          sunk << cell[:boat]
        end
      end
    end
    sunk
  end

  def winner_user?
    floating(self.board_comp).length == 0
  end

  def winner_comp?
    floating(self.board_user).length == 0
  end

  def floating(board)
    floating = []
    board.each do |row|
      row.each do |cell|
        if cell.class == Hash && cell[:boat] && cell[:boat][:boat].include?(nil) && !floating.include?(cell[:boat])
          floating << cell[:boat]
        end
      end
    end
    floating
  end
end
