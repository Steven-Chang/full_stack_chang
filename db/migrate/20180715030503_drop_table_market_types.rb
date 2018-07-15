class DropTableMarketTypes < ActiveRecord::Migration[5.1]
  def change
    drop_table :market_types
  end
end
