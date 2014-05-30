class RemoveColumndFromNflTeam < ActiveRecord::Migration
  def up
    remove_column :nfl_teams, :location
    remove_column :nfl_teams, :mascot
    remove_column :nfl_teams, :abbreviation

    add_column :nfl_teams, :code, :string
    add_column :nfl_teams, :full_name, :string
    add_column :nfl_teams, :short_name, :string
  end
end
