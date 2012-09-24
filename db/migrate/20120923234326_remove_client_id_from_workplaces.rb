class RemoveClientIdFromWorkplaces < ActiveRecord::Migration
  def up
    remove_column :workplaces, :client_id
  end

  def down
    add_column :workplaces, :client_id, :integer
  end
end
