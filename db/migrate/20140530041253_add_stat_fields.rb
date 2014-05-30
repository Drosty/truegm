class AddStatFields < ActiveRecord::Migration
  def change
    add_column :stats, :opponent, :string
    add_column :stats, :final_score, :string
    add_column :stats, :played, :bool
    add_column :stats, :started, :bool
    add_column :stats, :passing_completions, :integer
    add_column :stats, :passing_attempts, :integer
    add_column :stats, :passing_percentage, :float
    add_column :stats, :average_pass_yards, :float
    add_column :stats, :qb_rating, :float
    add_column :stats, :rushing_attempts, :integer
    add_column :stats, :rushing_average, :float
    add_column :stats, :fumbles, :integer
    add_column :stats, :longRun, :integer
    add_column :stats, :receiving_average, :float
    add_column :stats, :receiving_long, :int
  end
end
