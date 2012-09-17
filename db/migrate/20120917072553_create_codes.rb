class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :number, null: false
      t.text :detail, null: false

      t.timestamps
    end
  end
end
