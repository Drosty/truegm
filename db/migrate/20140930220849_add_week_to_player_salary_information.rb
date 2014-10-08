class AddWeekToPlayerSalaryInformation < ActiveRecord::Migration
  def change
    add_column :player_salary_informations, :week, :integer
  end
end
