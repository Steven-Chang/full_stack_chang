class AddMarketTypeToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :market_type, :integer, default: 0, null: false
  end
end
