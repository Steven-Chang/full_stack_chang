class PaymentSummarySerializer < ActiveModel::Serializer
  attributes :id, :gross_payment, :total_tax_withheld, :year_ending, :total_allowances, :client_id
end
