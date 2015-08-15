class CreateKickingStats < ActiveRecord::Migration
  def change
    create_table :kicking_stats do |t|
      t.references :nfl_matchup, index: true
      t.references :nfl_player, index: true
      t.references :nfl_team, index: true
      t.integer :number
      t.string :position
      t.string :fantasy_position
      t.float :fantasy_points
      t.integer :extra_points_attempted
      t.integer :extra_points_made
      t.float :field_goal_percentage
      t.integer :field_goals_attempted
      t.integer :field_goals_longest_made
      t.integer :field_goals_made

      t.timestamps null: false
    end
    add_foreign_key :kicking_stats, :nfl_matchups
    add_foreign_key :kicking_stats, :nfl_players
    add_foreign_key :kicking_stats, :nfl_teams
  end
end
