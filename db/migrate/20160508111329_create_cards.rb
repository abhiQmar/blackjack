class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user
      t.integer :game_id
      t.string :value, limit: 3

      t.timestamps null: false
    end
  end
end
