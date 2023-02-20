class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.boolean :is_finished, default: false
      t.integer :winner_id, default: 0
      t.integer :player_one
      t.integer :player_two

      t.timestamps
    end
  end
end
