# frozen_string_literal: true

FactoryBot.define do
  factory :exchange do
    sequence(:identifier) { |n| "exchange-#{n}" }
    sequence(:name) { |n| "exchange #{n}" }
    sequence(:url) { |n| "https://www.exchange#{n}.com" }
    maker_fee { 0.005 }
    taker_fee { 0.0025 }
  end
end
