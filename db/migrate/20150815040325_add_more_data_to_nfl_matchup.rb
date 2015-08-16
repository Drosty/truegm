class AddMoreDataToNflMatchup < ActiveRecord::Migration
  def change
    add_column :nfl_matchups, :away_score, :integer
    add_column :nfl_matchups, :home_score, :integer
    add_column :nfl_matchups, :quarter, :integer
    add_column :nfl_matchups, :time_remaining, :string, :default => "0:00"
    add_column :nfl_matchups, :possession, :string
    add_column :nfl_matchups, :down, :integer
    add_column :nfl_matchups, :distance, :integer
    add_column :nfl_matchups, :yard_line, :integer
    add_column :nfl_matchups, :yard_line_territory, :string
    add_column :nfl_matchups, :red_zone, :boolean, :default => false
    add_column :nfl_matchups, :away_score_quarter1, :integer
    add_column :nfl_matchups, :away_score_quarter2, :integer
    add_column :nfl_matchups, :away_score_quarter3, :integer
    add_column :nfl_matchups, :away_score_quarter4, :integer
    add_column :nfl_matchups, :away_score_overtime, :integer
    add_column :nfl_matchups, :home_score_quarter1, :integer
    add_column :nfl_matchups, :home_score_quarter2, :integer
    add_column :nfl_matchups, :home_score_quarter3, :integer
    add_column :nfl_matchups, :home_score_quarter4, :integer
    add_column :nfl_matchups, :home_score_overtime, :integer
    add_column :nfl_matchups, :has_started, :boolean, :default => false
    add_column :nfl_matchups, :is_in_progress, :boolean, :default => false
    add_column :nfl_matchups, :is_over, :boolean, :default => false
    add_column :nfl_matchups, :has1st_quarter_started, :boolean, :default => false
    add_column :nfl_matchups, :has2nd_quarter_started, :boolean, :default => false
    add_column :nfl_matchups, :has3rd_quarter_started, :boolean, :default => false
    add_column :nfl_matchups, :has4th_quarter_started, :boolean, :default => false
    add_column :nfl_matchups, :is_overtime, :boolean, :default => false
    add_column :nfl_matchups, :down_and_distance, :string, :default => "1st and 10"
    add_column :nfl_matchups, :quarter_description, :string
    add_column :nfl_matchups, :last_updated, :datetime
  end
end
