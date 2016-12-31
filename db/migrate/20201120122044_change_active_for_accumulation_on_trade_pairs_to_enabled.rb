class ChangeActiveForAccumulationOnTradePairsToEnabled < ActiveRecord::Migration[6.0]
  def change
    rename_column :trade_pairs, :active_for_accumulation, :enabled
  end
end
