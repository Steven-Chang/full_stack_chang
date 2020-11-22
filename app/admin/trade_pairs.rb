# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register TradePair do
  # === CONFIG ===
  config.sort_order = 'symbol_asc'

  # === INDEX ===
  index do
    column :symbol
    column :exchange do |trade_pair|
      trade_pair.exchange.identifier
    end
    column :credential do |trade_pair|
      trade_pair.credential&.identifier
    end
    column :maker_fee
    column :taker_fee
    column :minimum_total
    column :amount_step
    column :price_precision
    column :open_orders_limit
    column :accumulate_time_limit_in_seconds
    column :enabled
    actions
  end

  filter :symbol
  filter :exchange

  # === SHOW ===
  show do
    attributes_table do
      row :symbol
      row :exchange do |trade_pair|
        trade_pair.exchange.identifier
      end
      row :credential do |trade_pair|
        trade_pair.credential&.identifier
      end
      row :url
      row :maker_fee
      row :taker_fee
      row :minimum_total
      row :amount_step
      row :price_precision
      row :open_orders_limit
      row :accumulate_time_limit_in_seconds
      row :enabled
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :symbol
      f.input :exchange, member_label: :identifier, collection: Exchange.order('LOWER(identifier)')
      f.input :credential, member_label: :identifier, collection: Credential.order('LOWER(identifier)')
      f.input :url
      f.input :maker_fee
      f.input :taker_fee
      f.input :minimum_total
      f.input :amount_step
      f.input :price_precision
      f.input :open_orders_limit
      f.input :accumulate_time_limit_in_seconds
      f.input :enabled
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :symbol,
                :exchange_id,
                :credential_id,
                :open_orders_limit,
                :url,
                :maker_fee,
                :taker_fee,
                :minimum_total,
                :amount_step,
                :price_precision,
                :accumulate_time_limit_in_seconds,
                :enabled
end
