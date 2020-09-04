class DropTableCryptoExchanges < ActiveRecord::Migration[6.0]
  def change
    drop_table :crypto_exchanges
  end
end
