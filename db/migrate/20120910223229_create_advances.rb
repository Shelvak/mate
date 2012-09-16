class CreateAdvances < ActiveRecord::Migration
  def change
    create_table :advances do |t|
      t.date :charged_at, null: false
      t.text :detail, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.boolean :state, deafault: false, null: false

      t.timestamps
    end
  end
end
