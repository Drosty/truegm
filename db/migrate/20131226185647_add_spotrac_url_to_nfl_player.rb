class AddSpotracUrlToNflPlayer < ActiveRecord::Migration
  def change
    add_column :nfl_players, :spotrac_url, :string
  end
end
