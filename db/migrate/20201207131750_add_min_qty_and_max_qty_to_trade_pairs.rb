class AddMinQtyAndMaxQtyToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :min_qty, :integer
    add_column :trade_pairs, :max_qty, :integer
  end
end
