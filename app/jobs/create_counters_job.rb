# frozen_string_literal: true

class CreateCountersJob < ApplicationJob
  queue_as :low

  def perform
    Order.filled.buy.each do |order|
      next if order.child_order.present?

      order.save!
    end
  end
end
