class RemoveGrossPaymentsFromPaymentSummaries < ActiveRecord::Migration[5.1]
  def change
    remove_column :payment_summaries, :gross_payment, :integer
  end
end
