class CreatePaymentSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_summaries do |t|
      t.integer :gross_payment
      t.integer :total_tax_withheld
      t.integer :year_ending
      t.integer :total_allowances
      t.integer :client_id, null: false

      t.timestamps
    end
  end
end
