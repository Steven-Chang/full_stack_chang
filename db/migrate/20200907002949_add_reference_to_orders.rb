class AddReferenceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :reference, :string
  end
end
