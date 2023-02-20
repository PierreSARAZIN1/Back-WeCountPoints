class Match < ApplicationRecord
 has_many :points
 has_many :tennis_sets
 has_many :games, through: :tennis_sets
 has_many :players, through: :points

 
end
