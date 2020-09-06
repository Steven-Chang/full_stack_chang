class AddQuantityReceivedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :quantity_received, :decimal, precision: 8, scale: 6
  end
end
