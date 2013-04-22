class Game < ActiveRecord::Base

#   def new_boards
#     self.board_user = new_board unless board_user && board_user.length > 0
#     self.board_comp = new_board unless board_comp && board_comp.length > 0
#     self.board_user.board_size = BOARD_SIZE
#     self.board_comp.board_size = BOARD_SIZE
#   end
# 
#   def new_board
#     board = Board.new(BOARD_SIZE)
#     Array.new(BOARD_SIZE**2).map{|n| Unit.new }.each_slice(BOARD_SIZE) { |slice| board << slice }
#     board.each_with_index do |row, row_i|
#       row.each_with_index do |cell, cell_i|
#         cell.row = row_i
#         cell.cell = cell_i
#       end
#     end
#     self.add_ships!(board)
#   end
#   
#   def add_ships!(board)
#     [ Ship.new("Carrier", 5),
#       Ship.new("Battleship", 4),
#       Ship.new("Destroyer", 3),
#       Ship.new("Submarine 1", 2),
#       Ship.new("Submarine 2", 2),
#       Ship.new("Patrol Boat 1", 1),
#       Ship.new("Patrol Boat 2", 1)].shuffle.each do |ship|
#         self.add_ship!(ship, board)
#       end
#     board
#   end
# 
#   def add_ship!(ship, board)
#     row_i, cell_i, dir = gaps(ship.length + 2, board).sample
#     row_index = row_i
#     cell_index = cell_i
#     
#     ship.length.times do |n|
#       if dir == 'right'
#         cell_index = cell_i + 1 + n
#       else
#         row_index = row_i + 1 + n
#       end
#       unit = Unit.new({ship: ship, n: n, dir: dir, cell: cell_index, row: row_index})
#       board[row_index][cell_index] = unit
#     end
#   end
# 
#   def gaps(width, board)
#     set = []
#     board.each_with_index do |row, row_i|
#       len = 0
#       row.each_with_index do |cell, cell_i|
#         len += 1
#         if !cell.ship?
#           if len >= width
#             set << [row_i, cell_i - width + 1, 'right']
#           end
#         else
#           len = 0
#         end
#       end
#     end
# 
#     board.transpose.each_with_index do |row, row_i|
#       len = 0
#       row.each_with_index do |cell, cell_i|
#         len += 1
#         if !cell.ship?
#           if len >= width
#             set << [cell_i - width + 1, row_i, 'down']
#           end
#         else
#           len = 0
#         end
#       end
#     end
#     set
#   end
# 
#   def fire!(row, cell)
#     self.board_comp[row][cell].hit!
#     volley!
#   end
# 
#   def volley!
#     board_user.targets.sample.hit!
#   end
# 
#   def winner_user?
#     self.board_comp.clear?
#   end
# 
#   def winner_comp?
#     self.board_user.clear?
#   end
# 
#   def win_message
#     return "Congrats! You've beaten the computer." if winner_user?
#     return "Ooooh. You lost to a machine." if winner_comp?
#   end
# end
#  
# class Unit
#   attr_accessor :ship, :n, :dir, :cell, :row
# 
#   def initialize(params = nil)
#     if params
#       @ship = params[:ship]
#       @n = params[:n]
#       @dir = params[:dir]
#       @cell = params[:cell]
#       @row = params[:row]
#     end
#   end
# 
#   def hit!
#     if ship?
#       @ship.body[@n] = 1
#     else
#       @ship = 1
#     end
#   end
# 
#   def hit?
#     return @ship.body[@n] == 1 if ship?
#     return @ship == 1
#   end
# 
#   def ship?
#     @ship.class == Ship
#   end
end
