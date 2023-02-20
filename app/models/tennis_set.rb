class TennisSet < ApplicationRecord
 belongs_to :match
 has_many :games


end
