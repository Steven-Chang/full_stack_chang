class TenancyAgreementSerializer < ActiveModel::Serializer
  attributes :id, :active, :amount, :bond, :starting_date

  belongs_to :property
  belongs_to :user
end
