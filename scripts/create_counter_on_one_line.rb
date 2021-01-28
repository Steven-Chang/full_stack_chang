# frozen_string_literal: true

Credential.find_by(identifier: 'steven').trade_pairs.find_by(symbol: 'ethbtc').orders.where(status: 'filled', buy_or_sell: 'buy').order(price: :asc).find_each do |order|
  next unless order.quantity_received

  order.create_counter
end

Credential.find_by(identifier: 'ella_kabel').trade_pairs.find_by(symbol: 'btcusdt').orders.where(status: 'filled', buy_or_sell: 'buy').order(price: :asc).find_each do |order|
  next unless order.quantity_received

  order.create_counter
end
