class RemoveAmountFromEntries < ActiveRecord::Migration[5.1]
  def change
    remove_column :entries, :amount, :decimal
  end
end
