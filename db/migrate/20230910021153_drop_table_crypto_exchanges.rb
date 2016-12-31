class DropTableCryptoExchanges < ActiveRecord::Migration[7.0]
  def change
    drop_table :crypto_exchanges
  end
end
