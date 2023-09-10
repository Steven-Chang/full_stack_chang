# frozen_string_literal: true

FactoryBot.define do
  factory :trade_pair do
    sequence(:symbol) { |n| "shitcoin-#{n}" }
    amount_step { 0.01 }
    minimum_total { 0.2 }
    price_precision { 7 }

    credential

    trait :fees_present do
      maker_fee { 0.1 }
      taker_fee { 0.1 }
    end
  end
end
