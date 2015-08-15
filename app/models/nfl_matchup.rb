class NflMatchup < ActiveRecord::Base
  attr_accessible :import_game_id, :week, :game_date,
                  :away_team_id, :home_team_id, :tv_station, :year,
                  :point_spread, :over_under, :game_key

  belongs_to :away_team, :foreign_key => 'away_team_id', :class_name => "NflTeam"
  belongs_to :home_team, :foreign_key => 'home_team_id', :class_name => "NflTeam"

  has_many :kicking_stats
  has_many :passing_stats
  has_many :punting_stats
  has_many :receiving_stats
  has_many :return_stats
  has_many :rushing_stats

  def home_or_away team
    return "at" if team == self.away_team
    return "vs" if team == self.home_team
    return "BYE"
  end

  def opponent_code team
    return self.home_team.code if team == self.away_team
    return self.away_team.code if team == self.home_team
    return "BYE"
  end

end
