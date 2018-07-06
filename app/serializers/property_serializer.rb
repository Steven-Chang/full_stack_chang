class PropertySerializer < ActiveModel::Serializer
  attributes :id, :address, :tenancy_agreements

  has_many :tenancy_agreements
end
