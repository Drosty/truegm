class AddFieldsToNflPlayer < ActiveRecord::Migration
  def change
    add_column :nfl_players, :current_status, :string
    add_column :nfl_players, :depth_order, :int
    add_column :nfl_players, :experience, :int
    add_column :nfl_players, :photo_url, :string
  end
end
