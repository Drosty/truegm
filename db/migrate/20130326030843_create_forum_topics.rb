class CreateForumTopics < ActiveRecord::Migration
  def change
    create_table :forum_topics do |t|
      t.integer :league_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
