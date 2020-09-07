# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Exchange do
  # === CONFIG ===
  config.sort_order = 'symbol_asc'

  # === INDEX ===
  index do
    column :symbol
    column :exchange do |e|
      e.identifier
    end
    column :maker_fee
    column :taker_fee
    column :minimum_total
    column :amount_step
    column :active_for_accumulation
    actions
  end

  filter :symbol
  filter :exchange

  # === SHOW ===
  show do
    attributes_table do
      row :symbol
      row :exchange do |e|
        e.identifier
      end
      row :url
      row :maker_fee
      row :taker_fee
      row :minimum_total
      row :amount_step
      row :active_for_accumulation
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :symbol
      f.input :exchange
      f.input :url
      f.input :maker_fee
      f.input :taker_fee
      f.input :minimum_total
      f.input :amount_step
      f.input :active_for_accumulation
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :symbol, :exchange, :url, :maker_fee, :taker_fee, :minimum_total, :amount_step, :active_for_accumulation
end
