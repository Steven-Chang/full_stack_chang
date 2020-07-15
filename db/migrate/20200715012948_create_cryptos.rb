class CreateCryptos < ActiveRecord::Migration[6.0]
  def change
    create_table :cryptos do |t|
      t.string :identifier, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
