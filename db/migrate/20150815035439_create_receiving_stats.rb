class CreateReceivingStats < ActiveRecord::Migration
  def change
    create_table :receiving_stats do |t|
      t.references :nfl_matchup, index: true
      t.references :nfl_player, index: true
      t.references :nfl_team, index: true
      t.integer :number
      t.string :position
      t.string :fantasy_position
      t.float :fantasy_points
      t.integer :fumbles_lost
      t.integer :receiving_long
      t.integer :receiving_targets
      t.integer :receiving_touchdowns
      t.integer :receiving_yards
      t.float :receiving_yards_per_reception
      t.float :receiving_yards_per_target
      t.float :reception_percentage
      t.integer :receptions
      t.integer :two_point_conversion_receptions

      t.timestamps null: false
    end
    add_foreign_key :receiving_stats, :nfl_matchups
    add_foreign_key :receiving_stats, :nfl_players
    add_foreign_key :receiving_stats, :nfl_teams
  end
end
