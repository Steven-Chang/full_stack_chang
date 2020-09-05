class CreateCryptoExchanges < ActiveRecord::Migration[6.0]  
  def change  
    create_table :crypto_exchanges do |t| 
      t.belongs_to :crypto  
      t.belongs_to :exchange  
      t.decimal :withdrawal_fee, precision: 8, scale: 6 
      t.decimal :maker_fee, precision: 8, scale: 6  
      t.decimal :taker_fee, precision: 8, scale: 6  

      t.timestamps  
    end 
  end
end