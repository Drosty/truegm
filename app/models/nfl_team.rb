class NflTeam < ActiveRecord::Base
  attr_accessible :code, :short_name, :full_name, :bye_week

  has_many :nfl_players
  has_many :home_matchups, :foreign_key => 'home_team_id', :class_name => "NflMatchup"
  has_many :away_matchups, :foreign_key => 'away_team_id', :class_name => "NflMatchup"

  def matchups
    NflMatchup.where("home_team_id = ? OR away_team_id = ?", self.id, self.id)
  end

  # this will return the NFL Team that this NFL Team is player and then
  # if it 'vs' or 'at' as a string
  def week_nfl_matchup week
    year = ENV["current_year"]

    matchup = matchups.where(year: year, week: week).first
    return matchup
  end

end
