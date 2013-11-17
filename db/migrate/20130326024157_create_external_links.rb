class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :external_links do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
