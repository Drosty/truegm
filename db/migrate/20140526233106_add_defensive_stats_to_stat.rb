class AddDefensiveStatsToStat < ActiveRecord::Migration
  def change
    add_column :stats, :tfl, :integer
    add_column :stats, :sacks, :integer
    add_column :stats, :qbhits, :integer
    add_column :stats, :defensive_interceptions, :integer
    add_column :stats, :fumbles_recovered, :integer
    add_column :stats, :safties, :integer
    add_column :stats, :defensive_tds, :integer
    add_column :stats, :return_tds, :integer
    add_column :stats, :points_allowed, :integer
  end
end
