class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.boolean :is_finished, default: false
      t.boolean :is_decisive, default: false
      t.integer :winner_id
      t.integer :player_one
      t.integer :player_two
      t.integer :player_one_score, default: 0
      t.integer :player_two_score, default: 0
      t.references :tennis_set, foreign_key: true

      t.timestamps
    end
  end
end
