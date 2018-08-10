class PaymentSummary < ApplicationRecord
  belongs_to :client

  has_many :attachments, as: :resource, dependent: :destroy

  validates_uniqueness_of :client_id, scope: :year_ending

  def gross_payment
    Client.find( self.client_id ).tranxactions.where(tax: true).where("amount > ?", 0).where("date >= ?", Date.new( self.year_ending - 1, 7, 1) ).where("date < ?", Date.new( self.year_ending, 7, 1 ))
  end

end
