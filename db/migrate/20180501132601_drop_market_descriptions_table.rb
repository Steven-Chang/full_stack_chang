class DropMarketDescriptionsTable < ActiveRecord::Migration
  def change
    drop_table :market_descriptions
  end
end
