FactoryBot.define do
  factory :trade_pair do
    symbol { 'BTCAUD' }
    
    association :exchange

    trait :fees_present do
      maker_fee { 0.001 }
      taker_fee { 0.001 }
    end
  end
end
