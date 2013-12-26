class AddFullNameToNflPlayer < ActiveRecord::Migration
  def change
    add_column :nfl_players, :full_name, :string
  end
end
