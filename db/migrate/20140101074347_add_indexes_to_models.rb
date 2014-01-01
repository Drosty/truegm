class AddIndexesToModels < ActiveRecord::Migration
  def change
    add_index :nfl_players_teams, :team_id
    add_index :nfl_players_teams, :nfl_player_id
    add_index :trade_items, [:item_id, :item_type]
  end
end
