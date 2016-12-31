class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges do |t|
      t.string :identifier, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.decimal :maker_fee, null: false, precision: 8, scale: 6, null: false
      t.decimal :taker_fee, null: false, precision: 8, scale: 6, null: false
      t.decimal :fiat_withdrawal_fee, default: 0

      t.timestamps
    end
  end
end
