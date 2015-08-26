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

require 'spec_helper'

describe ReceivingStat do
  pending "add some examples to (or delete) #{__FILE__}"
end
