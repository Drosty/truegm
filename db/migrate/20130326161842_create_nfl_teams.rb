class CreateNflTeams < ActiveRecord::Migration
  def change
    create_table :nfl_teams do |t|
      t.string :location
      t.string :mascot

      t.timestamps
    end
  end
end
