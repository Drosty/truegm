class NflTeam < ActiveRecord::Base
  attr_accessible :code, :short_name, :full_name

  has_many :nfl_players
  has_many :home_matchups, :foreign_key => 'home_team_id', :class_name => "NflMatchup"
  has_many :away_matchups, :foreign_key => 'away_team_id', :class_name => "NflMatchup"

  # this will return the NFL Team that this NFL Team is player and then
  # if it 'vs' or 'at' as a string
  def week_opponent_and_home_or_away week
    year = ENV["current_year"]

    matchup = home_matchups.where(year: year, week: week).first
    unless matchup.nil?
      return matchup.away_team, "vs"
    end

    matchup = away_matchups.where(year: year, week: week).first
    unless matchup.nil?
      return matchup.home_team, "at"
    end

    return nil, nil
  end

end
