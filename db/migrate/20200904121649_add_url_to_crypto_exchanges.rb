class AddUrlToCryptoExchanges < ActiveRecord::Migration[6.0]
  def change
    add_column :crypto_exchanges, :url, :string
  end
end
