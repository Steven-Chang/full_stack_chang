class AddPriceToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :limit_price, :decimal, precision: 8, scale: 6
  end
end
