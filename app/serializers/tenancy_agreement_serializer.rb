class TenancyAgreementSerializer < ActiveModel::Serializer
  attributes :id, :amount, :bond, :starting_date

  belongs_to :property
  belongs_to :user
end
