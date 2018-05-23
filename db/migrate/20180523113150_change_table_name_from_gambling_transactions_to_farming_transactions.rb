class ChangeTableNameFromGamblingTransactionsToFarmingTransactions < ActiveRecord::Migration
  def change
    rename_table :gambling_transactions, :farming_transactions
  end
end
