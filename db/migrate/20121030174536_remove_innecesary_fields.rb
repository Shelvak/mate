class RemoveInnecesaryFields < ActiveRecord::Migration
  def up
    remove_column :banks, :amount
    remove_column :clients, :workplace_id
    remove_column :clients, :website
  end

  def down
    add_column :banks, :amount
    add_column :clients, :workplace_id
    add_column :clients, :website
  end
end
