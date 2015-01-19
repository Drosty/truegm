class DropProcessedStatsable < ActiveRecord::Migration
  def up
    drop_table :processed_stats
  end

  def down
    create_table :processed_stats do |t|
      t.references :stat, index: true
      t.references :league, index: true
      t.float :value

      t.timestamps
    end
  end
end
