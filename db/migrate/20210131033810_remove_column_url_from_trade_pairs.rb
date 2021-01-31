class RemoveColumnUrlFromTradePairs < ActiveRecord::Migration[6.0]
  def change
    remove_column :trade_pairs, :url, :string
  end
end
