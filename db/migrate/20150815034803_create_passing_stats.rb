class CreatePassingStats < ActiveRecord::Migration
  def change
    create_table :passing_stats do |t|
      t.references :nfl_matchup, index: true
      t.references :nfl_player, index: true
      t.references :nfl_team, index: true
      t.integer :number
      t.string :position
      t.string :fantasy_position
      t.float :fantasy_points
      t.integer :passing_attempts
      t.float :passing_completion_percentage
      t.integer :passing_completions
      t.integer :passing_interceptions
      t.integer :passing_long
      t.float :passing_rating
      t.integer :passing_sack_yards
      t.integer :passing_sacks
      t.integer :passing_touchdowns
      t.integer :passing_yards
      t.float :passing_yards_per_attempt
      t.float :passing_yards_per_completion
      t.integer :two_point_conversion_passes

      t.timestamps null: false
    end
    add_foreign_key :passing_stats, :nfl_matchups
    add_foreign_key :passing_stats, :nfl_players
    add_foreign_key :passing_stats, :nfl_teams
  end
end
