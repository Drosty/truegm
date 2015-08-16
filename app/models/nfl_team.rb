class NflTeam < ActiveRecord::Base
  attr_accessible :code, :short_name, :full_name, :bye_week, :spotrac_url

  has_many :nfl_players
  has_many :home_matchups, :foreign_key => 'home_team_id', :class_name => "NflMatchup"
  has_many :away_matchups, :foreign_key => 'away_team_id', :class_name => "NflMatchup"

  has_many :kicking_stats
  has_many :passing_stats
  has_many :punting_stats
  has_many :receiving_stats
  has_many :return_stats
  has_many :rushing_stats

  def matchups year
    raise "year must be passed in to get NFL Team Matchups" if year.nil?
    NflMatchup.where("(home_team_id = ? OR away_team_id = ?) and year = ?", self.id, self.id, year)
  end

  # this will return the NFL Team that this NFL Team is player and then
  # if it 'vs' or 'at' as a string
  def week_nfl_matchup week, year
    raise "year must be passed in to get NFL Weekly Matchup" if year.nil?
    raise "week must be passed in to get NFL Weekly Matchup" if week.nil?

    matchup = matchups(year).where(year: year, week: week).first
    return matchup
  end

end
