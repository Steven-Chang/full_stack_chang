class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description, null: false
      t.integer :amount, null: false

      t.timestamps null: false
    end
  end
end
