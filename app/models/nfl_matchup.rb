# == Schema Information
#
# Table name: nfl_matchups
#
#  id                     :integer          not null, primary key
#  import_game_id         :integer
#  week                   :integer
#  year                   :integer
#  game_date              :datetime
#  away_team_id           :integer
#  home_team_id           :integer
#  tv_station             :string
#  created_at             :datetime
#  updated_at             :datetime
#  point_spread           :float
#  over_under             :float
#  game_key               :string
#  away_score             :integer
#  home_score             :integer
#  quarter                :integer
#  time_remaining         :string           default("0:00")
#  possession             :string
#  down                   :integer
#  distance               :integer
#  yard_line              :integer
#  yard_line_territory    :string
#  red_zone               :boolean          default(FALSE)
#  away_score_quarter1    :integer
#  away_score_quarter2    :integer
#  away_score_quarter3    :integer
#  away_score_quarter4    :integer
#  away_score_overtime    :integer
#  home_score_quarter1    :integer
#  home_score_quarter2    :integer
#  home_score_quarter3    :integer
#  home_score_quarter4    :integer
#  home_score_overtime    :integer
#  has_started            :boolean          default(FALSE)
#  is_in_progress         :boolean          default(FALSE)
#  is_over                :boolean          default(FALSE)
#  has1st_quarter_started :boolean          default(FALSE)
#  has2nd_quarter_started :boolean          default(FALSE)
#  has3rd_quarter_started :boolean          default(FALSE)
#  has4th_quarter_started :boolean          default(FALSE)
#  is_overtime            :boolean          default(FALSE)
#  down_and_distance      :string           default("1st and 10")
#  quarter_description    :string
#  last_updated           :datetime
#

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
