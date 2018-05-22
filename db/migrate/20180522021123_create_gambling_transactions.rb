class CreateGamblingTransactions < ActiveRecord::Migration
  def change
    rename_table :transactions, :gambling_transactions
  end
end
