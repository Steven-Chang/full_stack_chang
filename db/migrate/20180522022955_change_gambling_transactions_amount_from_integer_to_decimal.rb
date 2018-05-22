class ChangeGamblingTransactionsAmountFromIntegerToDecimal < ActiveRecord::Migration
  def change
    change_column :gambling_transactions, :amount, :decimal, precision: 18, scale: 8
  end
end
