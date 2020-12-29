# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Order do
  # === ACTIONS ===
  actions :index

  # === CONFIG ===
  config.sort_order = 'updated_at_desc'

  # === MENU ===
  menu parent: 'Crypto'

  # === SCOPES ===
  scope :all, default: true
  scope :open
  scope :filled

  # === INDEX ===
  index do
    column :updated_at
    column :trade_pair do |order|
      order.trade_pair.symbol
    end
    column :credential do |order|
      "#{order.credential&.identifier} - #{order.exchange&.identifier}"
    end
    column :reference
    column :status
    column :buy_or_sell
    column :price
    column :quantity
    actions
  end

  filter :trade_pair_symbol, as: :select,
                             collection: lambda {
                              TradePair.pluck(:symbol).uniq.sort
                             }
  filter :credential, as: :select,
                      collection: lambda { Credential.all.map { |credential| ["#{credential.identifier} (#{credential.exchange.identifier})", credential.id] } }
  filter :status,
         as: :select,
         collection: proc { %w[open filled cancelled_stale] }
  filter :buy_or_sell,
         as: :select,
         collection: proc { %w[buy sell] }

  # === SHOW ===
  show do
    attributes_table do
      row :trade_pair do |order|
        order.trade_pair.symbol
      end
      row :exchange do |order|
        order.exchange.identifier
      end
      row :reference
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
      f.input :trade_pair, member_label: proc { |tp| "#{tp.symbol}: #{tp.exchange.identifier}" }
      f.input :reference
      f.input :status
      f.input :buy_or_sell
      f.input :price
      f.input :quantity
      f.input :quantity_received
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :reference, :status, :buy_or_sell, :price, :quantity, :quantity_received, :trade_pair_id
end
