class TradePairsAddPercentageFromMarketPriceBuyMinimumAndMaximum < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :percentage_from_market_price_buy_minimum, :decimal, precision: 8, scale: 6
    add_column :trade_pairs, :percentage_from_market_price_buy_maximum, :decimal, precision: 8, scale: 6
  end
end
