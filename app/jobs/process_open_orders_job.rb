# frozen_string_literal: true

class ProcessOpenOrdersJob < ApplicationJob
  queue_as :low

  def perform
    Credential.where(enabled: true)
              .find_each do |credential|
                applicable_orders_from_database = credential.orders
                                                            .where(status: %w[open partially_filled])
                                                            .joins(:trade_pair)
                                                            .where(trade_pairs: { enabled: true })
                applicable_orders_from_binance_references = []
                applicable_orders_from_binance_symbols = applicable_orders_from_database.pluck('trade_pairs.symbol').uniq
                # get the open orders from binance
                # update quantity received where applicable
                applicable_orders_from_binance_symbols.each do |symbol|
                  credential.client.open_orders(symbol: symbol.upcase).each do |binance_order|
                    reference = binance_order['orderId'].to_s
                    applicable_orders_from_binance_references.push(reference)
                    next unless (order = applicable_orders_from_database.find_by(reference: reference))

                    order.status = binance_order['status']
                    order.quantity_received = binance_order['cummulativeQuoteQty'].to_d
                    order.save! if order.will_save_change_to_quantity_received?
                  end
                end
                orders_to_update_from_exchange = applicable_orders_from_database.where.not(reference: applicable_orders_from_binance_references)
                orders_to_update_from_exchange.find_each do |order|
                  UpdateOrderFromExchangeJob.perform_later(order.id)
                end
    end
  end
end
