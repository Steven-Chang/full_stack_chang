# frozen_string_literal: true

class ChartsController < ApplicationController
  def total_scalped
    render json: scalped_orders.group_by_day { |u| u.created_at }
                               .map { |k, v|
                                 [k, v.map { |u| u.price * u.quantity }
                                      .inject(0) { |sum, el| sum + el }]
                               }.to_h
  end

  private

  def scalped_orders
    Order.where.not(order_id: nil)
         .where('created_at > ?', 2.weeks.ago)
         .where(status: 'filled')
  end
end
