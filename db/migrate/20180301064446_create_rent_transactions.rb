class CreateRentTransactions < ActiveRecord::Migration
  def change
    create_table :rent_transactions do |t|
      t.date :date, null: false
      t.string :description, null: false
      t.decimal :amount, precision: 8, scale: 2, default: 0.0, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
