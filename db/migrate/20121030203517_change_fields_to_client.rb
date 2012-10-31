class ChangeFieldsToClient < ActiveRecord::Migration
  def change
    add_column :clients, :firm_name, :string, null: false
    add_column :clients, :address, :string
    add_column :clients, :iva_responsive, :string, limit: 1, null: false
    
    add_index :clients, :firm_name
  end
end
