class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name, null: false
      t.string :website
      t.decimal :amount, precision: 15, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
