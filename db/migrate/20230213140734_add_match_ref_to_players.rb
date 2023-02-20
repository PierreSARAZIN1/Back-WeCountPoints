class AddMatchRefToPlayers < ActiveRecord::Migration[7.0]
  def change
   add_reference :players, :match, foreign: true
  end
end
