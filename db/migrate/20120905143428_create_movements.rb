class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.date :charged_at, null: false
      t.string :mov_number, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.decimal :total_amount, precision: 15, scale: 2
      t.text :comment
      t.string :devoted
      t.string :deposited_in
      t.date :devoted_at
      t.integer :code_id, null: false
      t.integer :bank_id, null: false
      t.integer :client_id, null: false

      t.timestamps
    end
  end
end
