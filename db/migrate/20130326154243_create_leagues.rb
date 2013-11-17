class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :description
      t.string :tagline

      t.timestamps
    end
  end
end
