# frozen_string_literal: true

FactoryBot.define do
  factory :trade_pair do
    symbol { 'shitcoin' }
    amount_step { 0.01 }
    minimum_total { 0.2 }
    price_precision { 7 }

    association :exchange

    trait :fees_present do
      maker_fee { 0.1 }
      taker_fee { 0.1 }
    end
  end
end
