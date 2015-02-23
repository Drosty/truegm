class AddFieldsToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :min_team_players, :integer, :default => 14
    add_column :leagues, :max_team_players, :integer, :default => 15
    add_column :leagues, :starting_qb_slots, :integer, :default => 1
    add_column :leagues, :starting_rb_slots, :integer, :default => 2
    add_column :leagues, :starting_wr_slots, :integer, :default => 2
    add_column :leagues, :starting_te_slots, :integer, :default => 1
    add_column :leagues, :starting_d_slots, :integer, :default => 1
    add_column :leagues, :starting_flex_wrte_slots, :integer, :default => 0
    add_column :leagues, :starting_flex_rbwrte_slots, :integer, :default => 1
    add_column :leagues, :starting_k_slots, :integer, :default => 1
    add_column :leagues, :player_salary_type, :string, :default => "real"
    add_column :leagues, :ir_slots, :integer, :default => 1
    add_column :leagues, :ir_players_tradeable, :boolean, :default => false
    add_column :leagues, :ir_cap_relief_max, :integer, :default => 5000000
    add_column :leagues, :ir_re_activatable, :boolean, :default => false
    add_column :leagues, :ir_reactivation_penalty, :integer, :default => 0
    add_column :leagues, :configuration_editable, :boolean, :default => true
    add_column :leagues, :playoffs_start_week, :integer, :default => 13
  end
end
