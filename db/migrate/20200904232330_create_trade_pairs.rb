class CreateTradePairs < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_pairs do |t|
      t.string :symbol, null: false
      t.string :url
      t.belongs_to :exchange
      t.decimal :withdrawal_fee, precision: 8, scale: 6
      t.decimal :maker_fee, precision: 8, scale: 6
      t.decimal :taker_fee, precision: 8, scale: 6

      t.timestamps
    end

    add_foreign_key "trade_pairs", "exchanges", name: "trade_pairs_exchange_id_fk"
  end
end
