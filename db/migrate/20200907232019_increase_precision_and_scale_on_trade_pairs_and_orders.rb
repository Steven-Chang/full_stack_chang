class IncreasePrecisionAndScaleOnTradePairsAndOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :trade_pairs, :minimum_total, :decimal, precision: 15, scale: 10
    change_column :trade_pairs, :amount_step, :decimal, precision: 15, scale: 10
    change_column :orders, :price, :decimal, precision: 15, scale: 10
    change_column :orders, :quantity, :decimal, precision: 15, scale: 10
  end
end
