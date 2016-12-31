class AddForeignKeyForOrdersTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "orders", "trade_pairs", name: "orders_trade_pair_id_fk"
  end
end
