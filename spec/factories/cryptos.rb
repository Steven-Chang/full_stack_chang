# frozen_string_literal: true

FactoryBot.define do
  factory :crypto do
    sequence(:identifier) { |n| "crypto-#{n}" }
    sequence(:name) { |n| "crypto #{n}" }
  end
end
