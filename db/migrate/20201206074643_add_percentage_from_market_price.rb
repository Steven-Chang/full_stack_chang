class AddPercentageFromMarketPrice < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :percentage_from_market_price, :decimal, precision: 8, scale: 6
  end
end
