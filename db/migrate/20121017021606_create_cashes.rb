class CreateCashes < ActiveRecord::Migration
  def change
    create_table :cashes do |t|
      t.decimal :amount, precision: 15, scale: 2, null:false, default: 0.0
      t.string :detail, null: false

      t.timestamps
    end

    add_index :cashes, :detail, unique: true
  end
end
