# frozen_string_literal: true

class ChartsController < ApplicationController
  def minutes_to_sale
    render json: Order.where.not(order_id: nil)
                      .where(status: 'filled')
                      .group_by_day { |u| u.created_at }
                      .map { |k, v|
                        [k, v.map { |u| ((u.updated_at - u.created_at) / 60).to_i }
                             .inject(0.0) { |sum, el| sum + el } / v.size]
                      }.to_h
  end
end
