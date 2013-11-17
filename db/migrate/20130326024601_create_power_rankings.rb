class CreatePowerRankings < ActiveRecord::Migration
  def change
    create_table :power_rankings do |t|
      t.integer :team_id
      t.text :description
      t.integer :rank
      t.integer :week
      t.integer :year

      t.timestamps
    end
  end
end
