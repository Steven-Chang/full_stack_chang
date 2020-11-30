# frozen_string_literal: true

class AccumulateCryptoJob < ApplicationJob
  after_perform do |_job|
    AccumulateCryptoJob.set(wait_until: Time.zone.now + TradePair::MAX_TRADE_FREQUENCY_IN_SECONDS.seconds).perform_later unless AccumulateCryptoJob.scheduled?
  end

  def perform
    Credential.trade
  end
end
