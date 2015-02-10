class UpdateStatsRecords < ActiveRecord::Migration
  def change
    remove_column :stats, :average_pass_yards
    remove_column :stats, :receiving_average
    remove_column :stats, :fumbles

    remove_column :stats, :sacks
    add_column :stats, :passing_sacks, :integer
    add_column :stats, :defensive_sacks, :integer

    remove_column :stats, :interceptions
    add_column :stats, :passing_interceptions, :integer

    add_column :stats, :receiving_targets, :integer
    add_column :stats, :two_point_conversion_receptions, :integer
    add_column :stats, :two_point_conversion_runs, :integer
  end
end
