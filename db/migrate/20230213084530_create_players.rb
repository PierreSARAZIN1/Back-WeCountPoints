class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :level
      t.integer :number_of_sets_won, default: 0

      t.timestamps
    end
  end
end
