class AddWeekAndSeasonToAllStatModels < ActiveRecord::Migration
  def change
    add_column :passing_stats, :week, :integer
    add_column :passing_stats, :season, :integer
    
    add_column :rushing_stats, :week, :integer
    add_column :rushing_stats, :season, :integer

    add_column :receiving_stats, :week, :integer
    add_column :receiving_stats, :season, :integer

    add_column :kicking_stats, :week, :integer
    add_column :kicking_stats, :season, :integer

    add_column :punting_stats, :week, :integer
    add_column :punting_stats, :season, :integer

    add_column :return_stats, :week, :integer
    add_column :return_stats, :season, :integer
  end
end
