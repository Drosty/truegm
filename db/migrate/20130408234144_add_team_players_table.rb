class AddTeamPlayersTable < ActiveRecord::Migration
  def up
    create_table :nfl_players_teams, :id => false do |t|
      t.integer :team_id
      t.integer :nfl_player_id
    end
  end

  def down
    drop_table :nfl_players_teams
  end
end
