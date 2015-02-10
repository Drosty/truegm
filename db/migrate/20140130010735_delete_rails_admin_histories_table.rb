class DeleteRailsAdminHistoriesTable < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? :rails_admin_histories
      drop_table :rails_admin_histories
    end
  end
end
