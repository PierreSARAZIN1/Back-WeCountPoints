class CreateTennisSets < ActiveRecord::Migration[7.0]
  def change
    create_table :tennis_sets do |t|
      t.boolean :is_finished, default: false
      t.integer :winner_id
      t.integer :player_one
      t.integer :player_two
      t.integer :player_one_score, default: 0
      t.integer :player_two_score, default: 0
      t.references :match, foreign_key: true

      t.timestamps
    end
  end
end
