class AddFantasyDataIdToNflPlayer < ActiveRecord::Migration
  def change
    add_column :nfl_players, :fantasy_data_id, :string
  end
end
