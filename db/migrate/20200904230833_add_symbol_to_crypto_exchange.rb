class AddSymbolToCryptoExchange < ActiveRecord::Migration[6.0]
  def change
    add_column :crypto_exchanges, :symbol, :string, null: false
  end
end
