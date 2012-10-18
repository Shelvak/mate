class AddFlowIdToCash < ActiveRecord::Migration
  def change
    add_column :cashes, :flow_id, :integer, null: :false

    add_index :cashes, :flow_id
  end
end
