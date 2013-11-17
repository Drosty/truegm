class CreateTradeItems < ActiveRecord::Migration
  def change
    create_table :trade_items do |t|
      t.integer :trade_id
      t.integer :item_id
      t.string :item_type
      t.integer :team
      t.string :value

      t.timestamps
    end
  end
end
