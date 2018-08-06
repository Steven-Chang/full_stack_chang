class PaymentSummary < ApplicationRecord
  belongs_to :client

  has_many :attachments, as: :resource, dependent: :destroy
end
