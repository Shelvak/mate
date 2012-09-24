class AddWorkplaceIdToClient < ActiveRecord::Migration
  def change
    add_column :clients, :workplace_id, :integer
  end
end
