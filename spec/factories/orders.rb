# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    status { 'filled' }
    buy_or_sell { 'buy' }

    association :trade_pair
  end
end
