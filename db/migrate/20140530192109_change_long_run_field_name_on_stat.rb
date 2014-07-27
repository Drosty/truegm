class ChangeLongRunFieldNameOnStat < ActiveRecord::Migration
  def change
    rename_column :stats, :longRun, :long_run
  end
end
