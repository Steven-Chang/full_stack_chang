class PaymentSummary < ApplicationRecord
  belongs_to :client

  has_many :attachments, as: :resource, dependent: :destroy

  validates_uniqueness_of :client_id, scope: :year_ending
end
