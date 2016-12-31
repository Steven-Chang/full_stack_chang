class AddOpenOrdersLimitToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :open_orders_limit, :integer
  end
end
