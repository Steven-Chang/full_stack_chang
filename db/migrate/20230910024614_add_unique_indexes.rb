class AddUniqueIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :trade_pairs, "LOWER(symbol), credential_id", unique: true
    remove_index :tools, :name
    add_index :tools, "LOWER(name)", unique: true
    add_index :tax_categories, "LOWER(description)", unique: true
    remove_index :creditors, :name
    add_index :creditors, "LOWER(name)", unique: true
    remove_index :orders, :order_id
    add_index :orders, :order_id, unique: true
  end
end
