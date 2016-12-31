# frozen_string_literal: true

ActiveAdmin.register Client do
  permit_params :email, :name

  # === MENU ===
  menu parent: 'Taxes'

  index do
    selectable_column
    id_column
    column :email
    column :name
    actions
  end

  filter :email
  filter :name

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
    end
    f.actions
  end
end
