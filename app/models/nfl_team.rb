class NflTeam < ActiveRecord::Base
  attr_accessible :location, :mascot, :abbreviation

  has_many :nfl_players
  has_many :matchups
end
