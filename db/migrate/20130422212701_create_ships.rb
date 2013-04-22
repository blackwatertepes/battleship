class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :board_id

      t.timestamps
    end
  end
end
