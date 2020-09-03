class ForeignKeyRelationshipOnCryptoExchangesAndExchangeId < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "crypto_exchanges", "exchanges", name: "crypto_exchanges_exchange_id_fk"
  end
end
