class CreateTranxactions < ActiveRecord::Migration[5.1]
  def change
    create_table :tranxactions do |t|
      t.date :date, null: false
      t.string :description, null: false
      t.decimal :amount, precision: 8, scale: 2, default: "0.0", null: false
      t.integer :transaction_type_id

      t.timestamps
    end
  end
end
