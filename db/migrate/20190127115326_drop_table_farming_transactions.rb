class DropTableFarmingTransactions < ActiveRecord::Migration[5.1]
  def change
    drop_table :farming_transactions
  end
end
