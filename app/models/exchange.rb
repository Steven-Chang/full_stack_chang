# frozen_string_literal: true

class Exchange < ApplicationRecord
  DEFAULT_EXCHANGES = {
    coinspot: {
      name: 'CoinSpot',
      url: 'https://www.coinspot.com.au/',
      maker_fee: 0.1,
      taker_fee: 0.1
    },
    binance: {
      name: 'Binance',
      url: 'https://www.binance.com/en',
      maker_fee: 0.1,
      taker_fee: 0.1
    }
  }.freeze

  # === ASSOCIATIONS ===
  has_many :trade_pairs, dependent: :destroy

  # === VALIDATIONS ===
  validates :identifier, :name, presence: true

  def self.arbitrage_opportunity_available

  end

  def self.create_default_exchanges
    DEFAULT_EXCHANGES.each do |identifier, value|
      next if Exchange.find_by(identifier: identifier)

      Exchange.create(identifier: identifier, name: value[:name], url: value[:url], maker_fee: value[:maker_fee], taker_fee: value[:taker_fee])
    end
  end

  def get_open_orders(symbol, buy_or_sell, number_of_orders = 1)
    case identifier
    when 'coinspot'
      m = Mechanize.new
      url = trade_pairs.find_by(symbol: symbol).url
      page = m.get(url)
      selector = buy_or_sell == 'buy' ? '.openbuyrows' : '.opensellrows'
      orders = []
      number_of_orders.times do |n|
        order = {
          amount: page.search(selector)[n - 1].children[1].text,
          rate: page.search(selector)[n - 1].children[3].text,
          total: page.search(selector)[n - 1].children[5].text
        }
        orders.push(order)
      end
    else
      return 'No exchange with that identifier'
    end

    orders
  end
end
