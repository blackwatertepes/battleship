class Game < ActiveRecord::Base
  
  has_many :boards

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
end
