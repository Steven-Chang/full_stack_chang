class CredentialExchangeId < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "credentials", "exchanges", name: "credentials_exchange_id_fk"
  end
end
