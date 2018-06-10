class RemoveDecimalFromClientPayments < ActiveRecord::Migration
  def change
    remove_column :client_payments, :decimal, :decimal
  end
end
