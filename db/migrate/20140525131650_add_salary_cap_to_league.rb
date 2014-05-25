class AddSalaryCapToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :salary_cap, :integer
  end
end
