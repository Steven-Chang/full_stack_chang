FactoryBot.define do
  factory :trade_pair do
    symbol { 'BTCAUD' }
    
    association :exchange
  end
end
