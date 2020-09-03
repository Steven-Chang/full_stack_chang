class AddForeignKeyRelationshipForCryptoExchangesAndCryptoId < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "crypto_exchanges", "cryptos", name: "crypto_exchanges_crypto_id_fk"
  end
end
