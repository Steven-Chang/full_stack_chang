# frozen_string_literal: true

FactoryBot.define do
  factory :credential do
    sequence(:identifier) { |n| "credential_#{n}" }

    exchange
  end
end
