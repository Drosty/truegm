class AddSpotracUrlToNflTeam < ActiveRecord::Migration
  def change
    add_column :nfl_teams, :spotrac_url, :string
  end
end
