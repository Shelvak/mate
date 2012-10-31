class ModifyCardsTable < ActiveRecord::Migration
  def change
    remove_column :cards, :website
    rename_column :cards, :address, :number
    add_column :cards, :expire_at, :date
    add_column :cards, :bank_id, :integer

    add_index :cards, :number, unique: true
    add_index :cards, :bank_id
  end
end
