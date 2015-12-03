class AddDefaultToNflPlayerSalary < ActiveRecord::Migration
  def up
    change_column :nfl_players, :salary, :integer, default: 0
  end

  def down
    change_column :nfl_players, :salary, :integer, default: nil
  end
end
