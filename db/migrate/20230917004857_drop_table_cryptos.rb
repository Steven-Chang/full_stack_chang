class DropTableCryptos < ActiveRecord::Migration[7.0]
  def change
    drop_table :cryptos
  end
end
