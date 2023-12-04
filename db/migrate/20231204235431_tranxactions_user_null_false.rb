class TranxactionsUserNullFalse < ActiveRecord::Migration[7.0]
  def change
    change_column :tranxactions, :user_id, :bigint, null: false
  end
end
