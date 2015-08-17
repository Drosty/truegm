# == Schema Information
#
# Table name: punting_stats
#
#  id               :integer          not null, primary key
#  nfl_matchup_id   :integer
#  nfl_player_id    :integer
#  nfl_team_id      :integer
#  number           :integer
#  position         :string
#  fantasy_position :string
#  fantasy_points   :float
#  punt_average     :float
#  punt_inside20    :integer
#  punt_touchbacks  :integer
#  punt_yards       :integer
#  punts            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  week             :integer
#  season           :integer
#

class PuntingStat < ActiveRecord::Base
  include FantasyDataMapper

  attr_accessible :week, :season, :nfl_player_id

  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team

  def total_points league
    0
  end
end
