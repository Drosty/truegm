class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.string :name
      t.integer :qb1
      t.integer :rb1
      t.integer :rb2
      t.integer :wr1
      t.integer :wr2
      t.integer :te
      t.integer :flex
      t.integer :utility
      t.integer :pk

      t.integer :bench1
      t.integer :bench2
      t.integer :bench3
      t.integer :bench4
      t.integer :bench5
      t.integer :bench6
      
      t.timestamps null: false
    end
  end
end
