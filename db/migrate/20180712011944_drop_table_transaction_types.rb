class DropTableTransactionTypes < ActiveRecord::Migration[5.1]
  def change
    drop_table :transaction_types
  end
end
