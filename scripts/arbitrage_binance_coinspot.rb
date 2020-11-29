# frozen_string_literal: true

# This is still going to be a bit of a punt as orders might not get filled exactly as wanted.
# I guess it's all about probability

# Make sure you get that fee stuff right
# I'm thinking you're gonna have to buy on coinspot then sell on binance to begin with and then it's going to balance from there.

btcaud_trade_pair = Exchange.find_by(identifier: 'binance').trade_pairs.find_by(symbol: 'btcaud')
btcaud_first_open_buy_order = btcaud_trade_pair.get_open_orders('buy', 3)[0]
btcaud_rate = btcaud_first_open_buy_order[:rate].to_d

c_btcaud_trade_pair = Exchange.find_by(identifier: 'coinspot').trade_pairs.find_by(symbol: 'btcaud')
c_btcaud_first_open_buy_order = c_btcaud_trade_pair.get_open_orders('sell', 3)[0]
c_btcaud_rate = c_btcaud_first_open_buy_order[:rate_cents] / 100.0

# Buy on coinspot
# Sell on Binance
# So the rate purchased at coinspot has to be lower than
# Binance selling rate
puts c_btcaud_rate
puts btcaud_rate
