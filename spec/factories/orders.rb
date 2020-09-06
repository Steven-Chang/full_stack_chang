# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    status { 'filled' }
    buy_or_sell { 'buy' }
    price { 0.01 }
    quantity { 0.01 }

    association :trade_pair
  end
end
