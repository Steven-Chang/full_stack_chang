class ClientPaymentSerializer < ActiveModel::Serializer
  attributes :id, :date, :amount

  belongs_to :client
end
