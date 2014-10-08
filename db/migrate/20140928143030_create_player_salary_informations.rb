class CreatePlayerSalaryInformations < ActiveRecord::Migration
  def change
    create_table :player_salary_informations do |t|
      t.integer :fantasy_data_id
      t.string :player_name
      t.string :position
      t.string :team
      t.integer :salary
      t.float :projection

      t.timestamps
    end
  end
end
