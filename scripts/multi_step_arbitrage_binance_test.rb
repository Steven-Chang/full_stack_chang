# frozen_string_literal: true

cred = Credential.find_by(identifier: 'steven')
cl = cred.trade_pairs.first.client
btc_usdt_trade_pair = cred.trade_pairs.find_by(symbol: 'btcusdt')
scrt_btc_trade_pair = cred.trade_pairs.find_by(symbol: 'scrtbtc')
scrt_eth_trade_pair = cred.trade_pairs.find_by(symbol: 'scrteth')
eth_usdt_trade_pair = cred.trade_pairs.find_by(symbol: 'ethusdt')

# get price for
btc_usdt_next_sale_price = btc_usdt_trade_pair.get_open_sell_orders(5)[0][:rate].to_d
scrt_btc_next_sale_price = scrt_btc_trade_pair.get_open_sell_orders(5)[0][:rate].to_d
scrt_eth_next_buy_price = scrt_eth_trade_pair.get_open_buy_orders(5)[0][:rate].to_d
eth_usdt_next_buy_price = eth_usdt_trade_pair.get_open_buy_orders(5)[0][:rate].to_d

btc = 30 * btc_usdt_next_sale_price
scrt = btc * scrt_btc_next_sale_price
eth = scrt * scrt_eth_next_buy_price
usdt = eth_usdt_next_buy_price * eth

usdt - 30