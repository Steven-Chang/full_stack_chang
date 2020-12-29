# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register TradePair do
  # === CONFIG ===
  config.sort_order = 'symbol_asc'

  # === MENU ===
  menu parent: 'Crypto'

  # === SCOPES ===
  scope :all
  scope :enabled, default: true

  # === BATCH ACTIONS ===
  batch_action :enabled_false do |ids|
    batch_action_collection.find(ids).each do |trade_pair|
      trade_pair.update!(enabled: false)
    end
    redirect_to collection_path, notice: 'Trade pairs disabled'
  end

  batch_action :enabled_true do |ids|
    batch_action_collection.find(ids).each do |trade_pair|
      trade_pair.update!(enabled: true)
    end
    redirect_to collection_path, notice: 'Trade pairs enabled'
  end

  batch_action :mode_buy do |ids|
    batch_action_collection.find(ids).each do |trade_pair|
      trade_pair.update!(mode: 'buy')
    end
    redirect_to collection_path, notice: 'Modes updated to buy'
  end

  batch_action :mode_counter_only do |ids|
    batch_action_collection.find(ids).each do |trade_pair|
      trade_pair.update!(mode: 'counter_only')
    end
    redirect_to collection_path, notice: 'Modes updated to counter_only'
  end

  batch_action :mode_scalp do |ids|
    batch_action_collection.find(ids).each do |trade_pair|
      trade_pair.update!(mode: 0)
    end
    redirect_to collection_path, notice: 'Modes updated to scalp'
  end

  # === INDEX ===
  index do
    selectable_column
    column :symbol
    column :credential do |trade_pair|
      "#{trade_pair.credential&.identifier} - #{trade_pair.exchange&.identifier}"
    end
    column :accumulate_time_limit_in_seconds
    column :mode
    column :enabled
    actions
  end

  filter :symbol
  filter :credential, collection: lambda {
    Credential.all.map { |credential| ["#{credential.identifier} (#{credential.exchange.identifier})", credential.id] }
  }
  filter :mode
  filter :maker_fee
  filter :taker_fee
  filter :open_orders_limit
  filter :minimum_hodl_quantity
  filter :maximum_hodl_quantity
  filter :enabled

  # === SHOW ===
  show do
    attributes_table do
      row :symbol
      row :exchange do |trade_pair|
        trade_pair.exchange&.identifier
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
      row :minimum_hodl_quantity
      row :maximum_hodl_quantity
      row :percentage_from_market_price_buy_minimum
      row :percentage_from_market_price_buy_maximum
      row :open_orders_limit
      row :accumulate_time_limit_in_seconds
      row :mode
      row :enabled
    end
    active_admin_comments
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :symbol
      f.input :credential, member_label: :identifier, collection: Credential.order('LOWER(identifier)')
      f.input :url
      f.input :maker_fee
      f.input :taker_fee
      f.input :minimum_total
      f.input :amount_step
      f.input :price_precision
      f.input :minimum_hodl_quantity
      f.input :maximum_hodl_quantity
      f.input :percentage_from_market_price_buy_minimum
      f.input :percentage_from_market_price_buy_maximum
      f.input :open_orders_limit
      f.input :accumulate_time_limit_in_seconds
      f.input :mode
      f.input :enabled
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :symbol,
                :credential_id,
                :open_orders_limit,
                :url,
                :maker_fee,
                :maximum_hodl_quantity,
                :minimum_hodl_quantity,
                :percentage_from_market_price_buy_minimum,
                :percentage_from_market_price_buy_maximum,
                :taker_fee,
                :minimum_total,
                :amount_step,
                :price_precision,
                :accumulate_time_limit_in_seconds,
                :mode,
                :enabled
end
