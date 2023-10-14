class DropTradingTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :credentials
    drop_table :exchanges
    drop_table :orders
    drop_table :trade_pairs
  end
end
