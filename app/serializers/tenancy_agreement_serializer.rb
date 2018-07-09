class TenancyAgreementSerializer < ActiveModel::Serializer
  attributes :id, :amount, :starting_date

  belongs_to :user
end
