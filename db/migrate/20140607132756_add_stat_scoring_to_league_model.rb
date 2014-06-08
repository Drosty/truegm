class AddStatScoringToLeagueModel < ActiveRecord::Migration
  def change
    add_column :leagues, :passing_yard_points, :float, :default => 0.04
    add_column :leagues, :passing_touchdown_points, :integer, :default => 5
    add_column :leagues, :passing_interception_points, :float, :default => -2
    add_column :leagues, :fumbles_lost_points, :float, :default => -2
    add_column :leagues, :rushing_yards_points, :float, :default => 0.1
    add_column :leagues, :rushing_touchdown_points, :integer, :default => 6
    add_column :leagues, :receiving_yards_points, :float, :default => 0.1
    add_column :leagues, :receiving_touchdown_points, :integer, :default => 6
    add_column :leagues, :points_per_reception_points, :float, :default => 1
    add_column :leagues, :defensive_interception_points, :float, :default => 2
    add_column :leagues, :defensive_fumble_recovered_points, :float, :default => 2
    add_column :leagues, :defensive_sack_points, :integer, :default => 1
    add_column :leagues, :defensive_saftey_points, :integer, :default => 2
    add_column :leagues, :defensive_touchdown_points, :integer, :default => 6
    add_column :leagues, :defensive_points_allowed_under_7_points, :float, :default => 10
    add_column :leagues, :defensive_points_allowed_under_14_points, :float, :default => 7
    add_column :leagues, :defensive_points_allowed_under_21_points, :float, :default => 1
    add_column :leagues, :defensive_points_allowed_under_28_points, :float, :default => 0
    add_column :leagues, :defensive_points_allowed_under_35_points, :float, :default => -1
    add_column :leagues, :defensive_points_allowed_equal_or_over_35_points, :float, :default => -4
  end
end
