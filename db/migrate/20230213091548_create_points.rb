class CreatePoints < ActiveRecord::Migration[7.0]
  def change
    create_table :points do |t|
     t.boolean :is_analyzed, default: false
     t.references :player, foreign_key: true
     t.timestamps
    end
  end
end
