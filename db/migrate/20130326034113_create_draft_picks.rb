class CreateDraftPicks < ActiveRecord::Migration
  def change
    create_table :draft_picks do |t|
      t.integer :team_id
      t.integer :year
      t.integer :round
      t.integer :position
      t.integer :original_team_id

      t.timestamps
    end
  end
end
