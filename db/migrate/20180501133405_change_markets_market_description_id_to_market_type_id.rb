class ChangeMarketsMarketDescriptionIdToMarketTypeId < ActiveRecord::Migration
  def change
    rename_column :markets, :market_description_id, :market_type_id
  end
end
