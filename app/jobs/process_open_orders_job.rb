# frozen_string_literal: true

class ProcessOpenOrdersJob < ApplicationJob
  queue_as :low

  def perform
    Credential.where(enabled: true)
              .find_each do |credential|
                applicable_orders_from_database = credential.orders
                                                            .where(status: 'open')
                                                            .joins(:trade_pair)
                                                            .where(trade_pairs: { enabled: true })
                open_orders_from_binance_references = []
                open_orders_from_binance_symbols = []
                # get the open orders from binance
                open_orders_from_binance = credential.client.open_orders
                open_orders_from_binance.each do |order|
                  reference = order[:reference]
                  open_orders_from_binance_references.push(reference)
                  open_orders_from_binance_symbols.push(order[:symbol])
                  applicable_orders_from_database.find_by(reference: reference)&.update(quantity_received: XXXX)
                end
                orders_to_update_from_exchange = applicable_orders_from_database.where.not(reference: open_orders_references)
                orders_to_update_from_exchange.find_each do |order|
                  UpdateOrderFromExchangeJob.perform_later(order.id)
                end
                open_orders_from_binance_symbols.each do |symbol|
                  unless CancelOutOfRangeOrdersJob.scheduled?
                    CancelOutOfRangeOrdersJob.set(at: Time.current + 5.seconds).perform_later(credential.exchange_id, symbol)
                  end
                end
    end
  end
end
