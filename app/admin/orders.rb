# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Order do
  # === CONFIG ===
  config.sort_order = 'updated_at_desc'

  # === INDEX ===
  index do
    column :trade_pair do |order|
      order.trade_pair.symbol
    end
    column :exchange do |order|
      order.exchange.identifier
    end
    column :status
    column :buy_or_sell
    column :price
    column :quantity
    column :quantity_received
    actions
  end

  filter :trade_pair
  filter :status
  filter :buy_or_sell

  # === SHOW ===
  show do
    attributes_table do
      row :trade_pair do |order|
        order.trade_pair.symbol
      end
      row :exchange do |order|
        order.exchange.identifier
      end
      row :status
      row :buy_or_sell
      row :price
      row :quantity
      row :quantity_received
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :trade_pair, member_label: Proc.new { |tp| "#{tp.symbol}: #{tp.exchange.identifier}" }, input_html: { disabled: true } 
      f.input :status
      f.input :buy_or_sell
      f.input :price
      f.input :quantity
      f.input :quantity_received
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :status, :buy_or_sell, :price, :quantity, :quantity_received
end
