class AddMatchRefToPoints < ActiveRecord::Migration[7.0]
  def change
   add_reference :points, :match, foreign: true
  end
end
