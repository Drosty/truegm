class AddByeWeekToNflTeam < ActiveRecord::Migration
  def change
    add_column :nfl_teams, :bye_week, :integer
  end
end
