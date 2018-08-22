class TranxactionSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :amount, :tax, :tax_category_id

  belongs_to :tax_category
  has_many :attachments
end
