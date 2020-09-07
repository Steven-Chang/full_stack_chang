class RemoveWithdrawalFeeFromTradePairs < ActiveRecord::Migration[6.0]
  def change
    remove_column :trade_pairs, :withdrawal_fee, :decimal
  end
end
