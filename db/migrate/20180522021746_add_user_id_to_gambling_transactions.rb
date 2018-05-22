class AddUserIdToGamblingTransactions < ActiveRecord::Migration
  def change
    add_column :gambling_transactions, :user_id, :integer
  end
end
