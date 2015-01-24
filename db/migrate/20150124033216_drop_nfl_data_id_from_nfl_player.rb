class DropNflDataIdFromNflPlayer < ActiveRecord::Migration
  def up
    remove_column :nfl_players, :nfl_data_id
  end

  def down
    add_column :nfl_players, :nfl_data_id, :bigint
  end
end
