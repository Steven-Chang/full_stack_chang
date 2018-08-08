class PaymentSummary < ApplicationRecord
  belongs_to :client

  has_many :attachments, as: :resource, dependent: :destroy

  validates :client_id, uniqueness: { scope: :year_ending }
end
