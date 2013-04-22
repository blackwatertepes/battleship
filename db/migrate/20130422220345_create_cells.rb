class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :ship_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
