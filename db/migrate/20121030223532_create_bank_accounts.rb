class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :number, null: false
      t.integer :office_number, null: false
      t.string :kind, limit: 1, null: false
      t.string :currency, limit: 1, null: false
      t.decimal :amount, presicion: 15, scale: 2, default: 0.0
      t.integer :bank_id, null: false

      t.timestamps
    end
    
    add_index :bank_accounts, :number, unique: true
    add_index :bank_accounts, :bank_id
  end
end
