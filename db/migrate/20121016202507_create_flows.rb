class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.string :code, null: false
      t.string :subcode, null: false
      t.date :charged_at, null: false
      t.string :detail, null: false
      t.integer :receipt, limit: 8 # For bigint
      t.integer :register, limit: 8 # For bigint
      t.decimal :total_amount, precision: 15, scale: 2, null: false, default: 0.00
      t.boolean :in, null: false, default: false

      t.timestamps
    end

    add_index :flows, :code
    add_index :flows, :subcode
  end
end
