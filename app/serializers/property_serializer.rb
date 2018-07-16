class PropertySerializer < ActiveModel::Serializer
  attributes :id, :address

  has_many :tenancy_agreements
end
