# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register TaxCategory do
  # === MENU ===
  menu parent: 'Taxes'
  
  # === INDEX ===
  index do
    column :description
    actions
  end

  filter :description

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :description
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :description
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :description
end
