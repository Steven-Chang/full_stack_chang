class TranxactionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :amount, :tax

  belongs_to :tax_category
  has_many :attachments
end
