class RemoveExchangeReferenceFromTradePairs < ActiveRecord::Migration[6.0]
  def change
    remove_reference :trade_pairs, :exchange, index: true, foreign_key: true
  end
end
