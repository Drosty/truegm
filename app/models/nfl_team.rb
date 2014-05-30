class NflTeam < ActiveRecord::Base
  attr_accessible :code, :short_name, :full_name

  has_many :nfl_players
  has_many :matchups
end
