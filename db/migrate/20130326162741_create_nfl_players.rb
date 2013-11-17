class CreateNflPlayers < ActiveRecord::Migration
  def change
    create_table :nfl_players do |t|
      t.integer :nfl_team_id
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :salary

      t.timestamps
    end
  end
end
