class AddColumnsToBanks < ActiveRecord::Migration
  def change
    add_column :banks, :phone, :string
    add_column :banks, :address, :string
    add_column :banks, :contact_name, :string
  end
end
