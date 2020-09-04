class RemoveForeignKeyForCryptoExchanges < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :crypto_exchanges, name: "crypto_exchanges_crypto_id_fk"
    remove_foreign_key :crypto_exchanges, name: "crypto_exchanges_exchange_id_fk"
  end
end
