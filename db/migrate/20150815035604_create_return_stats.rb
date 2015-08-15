class CreateReturnStats < ActiveRecord::Migration
  def change
    create_table :return_stats do |t|
      t.references :nfl_matchup, index: true
      t.references :nfl_player, index: true
      t.references :nfl_team, index: true
      t.integer :number
      t.string :position
      t.string :fantasy_position
      t.float :fantasy_points
      t.integer :kick_return_long
      t.integer :kick_return_touchdowns
      t.integer :kick_return_yards
      t.float :kick_return_yards_per_attempt
      t.integer :kick_returns
      t.integer :punt_return_long
      t.integer :punt_return_touchdowns
      t.integer :punt_return_yards
      t.float :punt_return_yards_per_attempt
      t.integer :punt_returns

      t.timestamps null: false
    end
    add_foreign_key :return_stats, :nfl_matchups
    add_foreign_key :return_stats, :nfl_players
    add_foreign_key :return_stats, :nfl_teams
  end
end
