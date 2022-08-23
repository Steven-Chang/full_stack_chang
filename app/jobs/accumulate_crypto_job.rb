# frozen_string_literal: true

class AccumulateCryptoJob < ApplicationJob
  def perform
    Credential.trade
  end
end
