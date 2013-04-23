class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :cells
      t.integer :rows
      t.integer :game_id
      t.integer :user_id

      t.timestamps
    end
  end
end
