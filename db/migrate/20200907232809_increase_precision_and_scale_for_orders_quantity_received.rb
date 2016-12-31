class IncreasePrecisionAndScaleForOrdersQuantityReceived < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :quantity_received, :decimal, precision: 15, scale: 10
  end
end
