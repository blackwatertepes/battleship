class CreateSalvos < ActiveRecord::Migration
  def change
    create_table :salvos do |t|
      t.integer :board_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
