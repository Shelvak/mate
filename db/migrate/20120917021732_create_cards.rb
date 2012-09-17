class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.string :address
      t.string :website

      t.timestamps
    end
  end
end
