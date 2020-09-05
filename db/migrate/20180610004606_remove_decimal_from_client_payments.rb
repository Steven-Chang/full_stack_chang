class RemoveDecimalFromClientPayments < ActiveRecord::Migration[4.2]
  def change
    remove_column :client_payments, :decimal, :decimal
  end
end
