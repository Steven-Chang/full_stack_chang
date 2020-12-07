# frozen_string_literal: true

cred_trade_pairs = Credential.find_by(identifier: 'chang_superfund', enabled: true).trade_pairs
cred_trade_pairs.where(symbol: %w[btcaud btcusdt ethaud ethusdt]).each do |trade_pair|
  trade_pair.orders.where(status: 'filled', buy_or_sell: 'buy').find_each do |order|
    next if order.child_order.present?
    next if order.quantity_received.blank?

    next_buy_or_sell = 'sell'
    next_quantity = order.quantity - order.trade_pair.amount_step
    next_price = (order.quantity_received * (1.0 + (order.taker_fee_for_calculation * 10))) / next_quantity
    next_symbol = case trade_pair.symbol
                  when 'btcusdt'
                    'btcusdc'
                  when 'ethusdt'
                    'ethusdc'
                  else
                    trade_pair.symbol
    end
    cred_trade_pairs.find_by(symbol: next_symbol).create_order(next_buy_or_sell, next_price, next_quantity, order.id)
  end
end
