# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Crypto do
  # === CONFIG ===
  config.sort_order = 'identifier_asc'

  # === MENU ===
  menu parent: 'Crypto'

  # === INDEX ===
  index do
    column :identifier
    column :name
    actions
  end

  filter :identifier
  filter :name

  # === SHOW ===
  show do
    attributes_table do
      row :identifier
      row :name
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :identifier
      f.input :name
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :identifier, :name
end
