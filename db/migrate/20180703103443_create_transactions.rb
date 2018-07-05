class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :date, null: false
      t.string :description, null: false
      t.decimal :amount, precision: 8, scale: 2, default: "0.0", null: false
      t.string :resource_class
      t.string :resource_id
      t.integer :transaction_type_id

      t.timestamps
    end
  end
end
