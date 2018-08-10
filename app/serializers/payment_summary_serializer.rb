class PaymentSummarySerializer < ActiveModel::Serializer
  attributes :id, :total_tax_withheld, :year_ending, :total_allowances, :client_id, :attachments, :gross_payment
end
