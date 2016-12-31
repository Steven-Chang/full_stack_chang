class AddMaximumOpenOrdersToExchanges < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :open_orders_limit_per_trade_pair, :integer
  end
end
