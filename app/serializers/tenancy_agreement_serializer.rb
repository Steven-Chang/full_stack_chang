class TenancyAgreementSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :user
end
