class AddMinQtyAndMaxQtyToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :minimum_hodl_quantity, :decimal, precision: 15, scale: 10
    add_column :trade_pairs, :maximum_hodl_quantity, :decimal, precision: 15, scale: 10
  end
end
