class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :charged_at, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.integer :batch
      t.date :expiration, null: false
      t.integer :place_id, null: false
      t.integer :card_id, null: false

      t.timestamps
    end
  end
end
