# frozen_string_literal: true

class TenancyAgreementSerializer < ActiveModel::Serializer
  attributes :id, :active, :amount, :bond, :starting_date, :balance

  belongs_to :property
  belongs_to :user
end
