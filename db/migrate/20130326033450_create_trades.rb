class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :from_team_id
      t.integer :to_team_id

      t.timestamps
    end
  end
end
