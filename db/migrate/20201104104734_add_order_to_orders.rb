class AddOrderToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :order, foreign_key: true
  end
end
