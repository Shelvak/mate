class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :firm_name, null: false
      t.string :ident, null: false
      t.string :address
      t.string :phone
      t.string :email
      t.string :iva_responsive, limit: 1, null: false

      t.timestamps
    end
    
    add_index :providers, :firm_name
    add_index :providers, :name, :unique => true
    add_index :providers, :ident, :unique => true
  end
end
