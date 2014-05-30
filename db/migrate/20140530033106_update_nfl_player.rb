class UpdateNflPlayer < ActiveRecord::Migration
  def change
    add_column :nfl_players, :jersey, :string
    add_column :nfl_players, :height, :string
    add_column :nfl_players, :weight, :string
    add_column :nfl_players, :dob, :datetime
    add_column :nfl_players, :college, :string
    add_column :nfl_players, :active, :bool
  end
end
