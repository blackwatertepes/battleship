class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :board_user
      t.text :board_comp
      t.string :winner
      t.integer :user_id

      t.timestamps
    end
  end
end
