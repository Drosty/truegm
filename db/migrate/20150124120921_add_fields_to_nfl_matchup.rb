class AddFieldsToNflMatchup < ActiveRecord::Migration
  def change
    add_column :nfl_matchups, :point_spread, :float
    add_column :nfl_matchups, :over_under, :float
  end
end
