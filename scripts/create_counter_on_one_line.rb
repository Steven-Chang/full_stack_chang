Credential.first.trade_pairs.find_by(symbol: 'ethaud').orders.where(status: 'filled', buy_or_sell: 'buy').order(price: :asc).find_each {|order| order.create_counter}
