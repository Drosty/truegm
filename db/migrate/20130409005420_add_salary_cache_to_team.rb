class AddSalaryCacheToTeam < ActiveRecord::Migration
  def up
    add_column :teams, :total_salary, :integer, :default => 0
  end

  def down
    remove_column :teams, :total_salary
  end
end
