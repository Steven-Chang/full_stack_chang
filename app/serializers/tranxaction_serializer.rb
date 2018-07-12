class TranxactionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :amount
end
