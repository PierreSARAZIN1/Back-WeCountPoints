class Player < ApplicationRecord

 validates :name, presence: true
 validates :level, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

 has_many :points
 has_one :match
 

 def register_player_in_match(player_params)
  @match = Match.find_by(id: player_params.match_id)
  @player = Player.find_by(id: player_params.id)
  if @match.player_one.blank?
   @match.update("player_one"=>@player.id)
   @match.tennis_sets.create("player_one"=>@player.id)
   @match.tennis_sets.last.games.create("player_one"=>@player.id)
  elsif @match.player_two.blank?
   @match.update("player_two"=>@player.id)
   @match.tennis_sets.last.update("player_two"=>@player.id)
   @match.tennis_sets.last.games.last.update("player_two"=>@player.id)
  else
   puts "Match has not been updated because it already contains two players"
  end
 end
 
end
