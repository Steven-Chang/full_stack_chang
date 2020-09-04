# frozen_string_literal: true

class Exchange < ApplicationRecord
  # === ASSOCIATIONS ===
  has_many :crypto_exchanges, dependent: :destroy
  has_many :cryptos, through: :crypto_exchanges

  # === VALIDATIONS ===
  validates :identifier, :name, presence: true

  def get_open_orders(crypto_identifier, buy_or_sell, number_of_orders = 1)
    crypto = Crypto.find_by(identifier: crypto_identifier.downcase)

    case identifier
    when 'coinspot'
      m = Mechanize.new
      url = crypto_exchanges.find_by(crypto: crypto).url
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
