class TranxactionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :amount, :tax

  has_many :attachments
end
