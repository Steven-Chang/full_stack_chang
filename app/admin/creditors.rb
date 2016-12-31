# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Creditor do
  # === CONFIG ===
  config.sort_order = 'name_asc'

  # === MENU ===
  menu parent: 'Taxes'

  # === INDEX ===
  index do
    column :name
    actions
  end

  filter :name

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :name
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :name
end
