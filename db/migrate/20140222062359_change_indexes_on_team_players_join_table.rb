class ChangeIndexesOnTeamPlayersJoinTable < ActiveRecord::Migration
  def up 
    remove_index(:nfl_players_teams, name: "index_nfl_players_teams_on_nfl_player_id")
    remove_index(:nfl_players_teams, name: "index_nfl_players_teams_on_team_id")

    add_index :nfl_players_teams, [:team_id, :nfl_player_id], :unique => true, :name => 'by_team_and_player'
  end

  def down
    remove_index(:nfl_players_teams, name: "by_team_and_player")

    add_index "nfl_players_teams", ["nfl_player_id"], name: "index_nfl_players_teams_on_nfl_player_id", using: :btree
    add_index "nfl_players_teams", ["team_id"], name: "index_nfl_players_teams_on_team_id", using: :btree
  end

end
