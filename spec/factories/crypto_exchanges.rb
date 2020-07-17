# frozen_string_literal: true

FactoryBot.define do
  factory :crypto_exchange do
    association :crypto
    association :exchange
  end
end
