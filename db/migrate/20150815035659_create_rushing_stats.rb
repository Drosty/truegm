class CreateRushingStats < ActiveRecord::Migration
  def change
    create_table :rushing_stats do |t|
      t.references :nfl_matchup, index: true
      t.references :nfl_player, index: true
      t.references :nfl_team, index: true
      t.integer :number
      t.string :position
      t.string :fantasy_position
      t.float :fantasy_points
      t.integer :fumbles_lost
      t.integer :rushing_attempts
      t.integer :rushing_long
      t.integer :rushing_touchdowns
      t.integer :rushing_yards
      t.float :rushing_yards_per_attempt
      t.integer :two_point_conversion_runs

      t.timestamps null: false
    end
    add_foreign_key :rushing_stats, :nfl_matchups
    add_foreign_key :rushing_stats, :nfl_players
    add_foreign_key :rushing_stats, :nfl_teams
  end
end
