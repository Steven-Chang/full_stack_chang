# frozen_string_literal: true

class AccumulateTradePairJob < ApplicationJob
  def perform(trade_pair_id)
    TradePair.find(trade_pair_id).accumulate
  end
end
