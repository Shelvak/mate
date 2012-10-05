class CreatePettyCashes < ActiveRecord::Migration
  def change
    create_table :petty_cashes do |t|
      t.date :charged_at, null: false
      t.text :detail, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.boolean :state, default: false, null: false

      t.timestamps
    end
  end
end
