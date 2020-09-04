# frozen_string_literal: true

FactoryBot.define do
  factory :crypto_exchange do
    association :crypto
    association :exchange

    trait :fees_present do
      maker_fee { 0.1 }
      taker_fee { 0.1 }
    end
  end
end
