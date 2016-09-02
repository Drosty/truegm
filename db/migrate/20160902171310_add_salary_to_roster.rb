class AddSalaryToRoster < ActiveRecord::Migration
  def change
    add_column :rosters, :salary, :integer
  end
end
