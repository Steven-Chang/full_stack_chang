class AddUniqueIndexToPaymentSummaries < ActiveRecord::Migration[5.1]
  def change
    add_index :payment_summaries, [:client_id, :year_ending], unique: true
  end
end
