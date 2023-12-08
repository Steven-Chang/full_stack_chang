class PaymentSummariesAddColumnTaxableIncome < ActiveRecord::Migration[7.0]
  def change
    add_column :payment_summaries, :taxable_income, :integer, default: 0
  end
end
