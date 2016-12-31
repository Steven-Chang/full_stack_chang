# frozen_string_literal: true

Order.filled.buy.each do |order|
  next if order.child_order.present?

  order.save!
end
