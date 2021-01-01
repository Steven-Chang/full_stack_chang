class IncreasePricePresicionAndScale < ActiveRecord::Migration[6.0]
  def change
    change_column :trade_pairs, :limit_price, :decimal, precision: 15, scale: 10
  end
end
