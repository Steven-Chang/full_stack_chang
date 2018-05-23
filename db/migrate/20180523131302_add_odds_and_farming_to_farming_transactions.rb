class AddOddsAndFarmingToFarmingTransactions < ActiveRecord::Migration
  def change
    add_column :farming_transactions, :date, :date
    add_column :farming_transactions, :odds, :decimal, precision: 18, scale: 8
    add_column :farming_transactions, :farming, :boolean
  end
end
