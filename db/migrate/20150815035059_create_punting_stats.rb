class CreatePuntingStats < ActiveRecord::Migration
  def change
    create_table :punting_stats do |t|
      t.references :nfl_matchup, index: true
      t.references :nfl_player, index: true
      t.references :nfl_team, index: true
      t.integer :number
      t.string :position
      t.string :fantasy_position
      t.float :fantasy_points
      t.float :punt_average
      t.integer :punt_inside20
      t.integer :punt_touchbacks
      t.integer :punt_yards
      t.integer :punts

      t.timestamps null: false
    end
    add_foreign_key :punting_stats, :nfl_matchups
    add_foreign_key :punting_stats, :nfl_players
    add_foreign_key :punting_stats, :nfl_teams
  end
end
