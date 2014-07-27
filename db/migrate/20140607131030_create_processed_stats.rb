class CreateProcessedStats < ActiveRecord::Migration
  def change
    create_table :processed_stats do |t|
      t.references :stat, index: true
      t.references :league, index: true
      t.float :value

      t.timestamps
    end
  end
end
