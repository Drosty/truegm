class CreateStatsTable < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :nfl_player, index: true
      t.integer :passing_yards
      t.integer :passing_touchdowns
      t.integer :interceptions
      t.integer :rushing_yards
      t.integer :rushing_touchdowns
      t.integer :receptions
      t.integer :receiving_yards
      t.integer :receiving_touchdowns
      t.integer :fumbles_lost
      t.integer :year
      t.integer :week
    end
  end
end
