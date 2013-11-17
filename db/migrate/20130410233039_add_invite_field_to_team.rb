class AddInviteFieldToTeam < ActiveRecord::Migration
  def up
    add_column :teams, :invite_code, :string
  end

  def down
    remove_column :teams, :invite_code
  end
end
