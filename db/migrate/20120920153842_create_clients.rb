class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :website
      t.string :ident, null: false

      t.timestamps
    end
    add_index :clients, :name, :unique => true
    add_index :clients, :ident, :unique => true
  end
end
