class League < ActiveRecord::Base
  attr_accessible :description, :name, :tagline, :salary_cap,
                  :passing_yard_points, :passing_touchdown_points,
                  :passing_interception_points, :fumbles_lost_points,
                  :rushing_yards_points, :rushing_touchdown_points,
                  :receiving_yards_points, :receiving_touchdown_points,
                  :points_per_reception_points, :defensive_interception_points,
                  :defensive_fumble_recovered_points, :defensive_sack_points,
                  :defensive_saftey_points, :defensive_touchdown_points,
                  :defensive_points_allowed_under_7_points,
                  :defensive_points_allowed_under_14_points,
                  :defensive_points_allowed_under_21_points,
                  :defensive_points_allowed_under_28_points,
                  :defensive_points_allowed_under_35_points,
                  :defensive_points_allowed_equal_or_over_35_points,
                  :teams_attributes

  has_many :teams
  accepts_nested_attributes_for :teams, :allow_destroy => true

  has_many :forum_topics

  validates_presence_of :tagline
  validates_length_of :name, :minimum => 5, :maximum => 20, :allow_blank => false

  def get_team_name_for_player nfl_player
    team = Team.joins(:nfl_players)
               .where(:teams => {:league_id => id}, :nfl_players => {:id => nfl_player.id})
               .first

    return "FA" if team.nil?
    team.name
  end

end
