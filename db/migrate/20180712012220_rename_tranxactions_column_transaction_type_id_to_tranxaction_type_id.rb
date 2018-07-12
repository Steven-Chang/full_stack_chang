class RenameTranxactionsColumnTransactionTypeIdToTranxactionTypeId < ActiveRecord::Migration[5.1]
  def change
    rename_column :tranxactions, :transaction_type_id, :tranxaction_type_id
  end
end
