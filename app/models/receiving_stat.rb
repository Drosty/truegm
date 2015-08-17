# == Schema Information
#
# Table name: receiving_stats
#
#  id                              :integer          not null, primary key
#  nfl_matchup_id                  :integer
#  nfl_player_id                   :integer
#  nfl_team_id                     :integer
#  number                          :integer
#  position                        :string
#  fantasy_position                :string
#  fantasy_points                  :float
#  fumbles_lost                    :integer
#  receiving_long                  :integer
#  receiving_targets               :integer
#  receiving_touchdowns            :integer
#  receiving_yards                 :integer
#  receiving_yards_per_reception   :float
#  receiving_yards_per_target      :float
#  reception_percentage            :float
#  receptions                      :integer
#  two_point_conversion_receptions :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  week                            :integer
#  season                          :integer
#

class ReceivingStat < ActiveRecord::Base
  include FantasyDataMapper
  
  attr_accessible :week, :season, :nfl_player_id

  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team

  def total_points league
    [
      receiving_touchdowns.to_i * league.receiving_touchdown_points,
      receiving_yards.to_f * league.receiving_yards_points,
      receptions.to_i * league.points_per_reception_points
    ].sum.round(2)
  end
end
