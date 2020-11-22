# frozen_string_literal: true

class Credential < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :exchange
  has_many :trade_pairs, dependent: :restrict_with_exception

  # === CLASS METHODS ===
  def self.create_defaults
    Rails.application.credentials.binance.each do |identifier, _v|
      next unless (exchange_binance = Exchange.find_by(identifier: 'binance'))
      next if Credential.find_by(identifier: identifier, exchange: exchange_binance).present?

      Credential.create(identifier: identifier, exchange: exchange_binance)
    end
  end
end
