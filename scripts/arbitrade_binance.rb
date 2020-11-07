# This is still going to be a bit of a punt as orders might not get filled exactly as wanted.
# I guess it's all about probability

# Looks like fee is taken off afterwards

audusdt_trade_pair = Exchange.find_by(identifier: 'binance').trade_pairs.find_by(symbol: 'audusdt')
audusdt_first_open_buy_order = audusdt_trade_pair.get_open_orders('buy', 3)[0]
audusdt_rate = audusdt_first_open_buy_order[:rate].to_d

btcusdt_trade_pair = Exchange.find_by(identifier: 'binance').trade_pairs.find_by(symbol: 'btcusdt')
btcusdt_first_open_sell_order = btcusdt_trade_pair.get_open_orders('sell', 3)[0]
btcusdt_rate = btcusdt_first_open_sell_order[:rate].to_d

btcaud_trade_pair = Exchange.find_by(identifier: 'binance').trade_pairs.find_by(symbol: 'btcaud')
btcaud_first_open_buy_order = btcaud_trade_pair.get_open_orders('buy', 3)[0]
btcaud_rate = btcaud_first_open_buy_order[:rate].to_d

if audusdt_first_open_buy_order[:amount] > 1
  # Sell 20 AUD for usdt
  # audusdt_trade_pair.create_order('sell', audusdt_rate, 20)
  usdt = 20 * audusdt_rate
  puts "USDT: #{usdt}"

  # buy btc with usdt
  btc = usdt / btcusdt_rate
  # btcusdt_trade_pair.create_order('buy', btcusdt_rate, usdt)
  puts "BTC: #{btc}"
  if btcusdt_first_open_sell_order[:amount] > 1 * btc
    if btcaud_first_open_buy_order[:amount] > 1 * btc
      # Sell btc for aud for profit
      aud = btcaud_rate * btc
      puts "AUD: #{aud}"
    end
  end
end
