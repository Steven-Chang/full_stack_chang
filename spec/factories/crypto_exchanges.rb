# frozen_string_literal: true

FactoryBot.define do
  factory :crypto_exchange do
    symbol { 'BTCAUD' }

    association :crypto
    association :exchange
  end
end
