class AddStatScoringToLeagueModel < ActiveRecord::Migration
  def change
    add_column :leagues, :passing_yard_points, :float
    add_column :leagues, :passing_touchdown_points, :integer
    add_column :leagues, :passing_interception_points, :float
    add_column :leagues, :fumbles_lost_points, :float
    add_column :leagues, :rushing_yards_points, :float
    add_column :leagues, :rushing_touchdown_points, :integer
    add_column :leagues, :receiving_yards_points, :float
    add_column :leagues, :receiving_touchdown_points, :integer
    add_column :leagues, :points_per_reception_points, :float
    add_column :leagues, :defensive_interception_points, :float
    add_column :leagues, :defensive_fumble_recovered_points, :float
    add_column :leagues, :defensive_sack_points, :integer
    add_column :leagues, :defensive_saftey_points, :integer
    add_column :leagues, :defensive_touchdown_points, :integer
    add_column :leagues, :defensive_points_allowed_under_7_points, :float
    add_column :leagues, :defensive_points_allowed_under_14_points, :float
    add_column :leagues, :defensive_points_allowed_under_21_points, :float
    add_column :leagues, :defensive_points_allowed_under_28_points, :float
    add_column :leagues, :defensive_points_allowed_under_35_points, :float
  end
end
