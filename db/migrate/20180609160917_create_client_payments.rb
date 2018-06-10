class CreateClientPayments < ActiveRecord::Migration
  def change
    create_table :client_payments do |t|
      t.integer :client_id, null: false
      t.decimal :amount, :decimal, precision: 18, scale: 8, default: 0
      t.date :date, null: false

      t.timestamps null: false
    end
  end
end
