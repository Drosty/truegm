class CreateNflMatchups < ActiveRecord::Migration
  def change
    create_table :nfl_matchups do |t|
      t.integer :import_game_id
      t.integer :week
      t.integer :year
      t.datetime :game_date
      t.integer :away_team_id
      t.integer :home_team_id
      t.string :tv_station

      t.timestamps
    end
  end
end
