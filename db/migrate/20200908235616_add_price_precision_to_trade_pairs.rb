class AddPricePrecisionToTradePairs < ActiveRecord::Migration[6.0]
  def change
    add_column :trade_pairs, :price_precision, :integer
  end
end
