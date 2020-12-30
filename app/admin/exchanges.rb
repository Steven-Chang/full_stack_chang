# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Exchange do
  # === CONFIG ===
  config.sort_order = 'identifier_asc'

  # === MENU ===
  menu parent: 'Crypto'

  # === CALLBACKS ===
  before_filter :skip_sidebar!, only: :index

  # === INDEX ===
  index do
    column :identifier
    column :name
    column :maker_fee
    column :taker_fee
    column :fiat_withdrawal_fee
    actions
  end

  filter :identifier
  filter :name

  # === SHOW ===
  show do
    attributes_table do
      row :identifier
      row :name
      row :url
      row :maker_fee
      row :taker_fee
      row :fiat_withdrawal_fee
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :identifier
      f.input :name
      f.input :url
      f.input :maker_fee
      f.input :taker_fee
      f.input :fiat_withdrawal_fee
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :identifier, :fiat_withdrawal_fee, :maker_fee, :name, :taker_fee, :url
end
