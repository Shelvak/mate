class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.string :address, null: false
      t.string :city
      t.string :state, null: false, default: 'Mendoza'
      t.string :country, null: false, default: 'Argentina'
      t.integer :client_id, null: false

      t.timestamps
    end
  end
end
