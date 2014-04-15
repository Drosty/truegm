class AddNflDataIdToNflPlayer < ActiveRecord::Migration
  def change
    add_column :nfl_players, :nfl_data_id, :bigint
    add_index :nfl_players, :nfl_data_id, :unique => true
  end
end
