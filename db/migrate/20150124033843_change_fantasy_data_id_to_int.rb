class ChangeFantasyDataIdToInt < ActiveRecord::Migration
  def up
    remove_column :nfl_players, :fantasy_data_id
    add_column :nfl_players, :fantasy_data_id, :int
  end

  def down
    remove_column :nfl_players, :fantasy_data_id
    add_column :nfl_players, :fantasy_data_id, :string
  end

end
