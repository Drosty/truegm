class CreateTradeVotes < ActiveRecord::Migration
  def change
    create_table :trade_votes do |t|
      t.integer :trade_id
      t.integer :team_id
      t.string :vote

      t.timestamps
    end
  end
end
