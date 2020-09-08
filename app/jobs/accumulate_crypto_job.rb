# frozen_string_literal: true

class AccumulateCryptoJob < ApplicationJob
  after_perform do |_job|
    AccumulateCryptoJob.set(wait_until: Time.zone.now + 1.minute).perform_later unless AccumulateCryptoJob.scheduled?
  end

  def perform
    TradePair.accumulate
  end
end