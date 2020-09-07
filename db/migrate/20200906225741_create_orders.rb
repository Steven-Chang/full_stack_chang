class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :status, null: false
      t.string :buy_or_sell, null: false
      t.decimal :price, precision: 8, scale: 6
      t.decimal :quantity, precision: 8, scale: 6

      t.references :trade_pair

      t.timestamps
    end
  end
end
