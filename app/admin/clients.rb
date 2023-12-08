# frozen_string_literal: true

ActiveAdmin.register Client do
  # === MENU ===
  menu parent: 'Taxes'

  # === INDEX ===
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :user
    actions
  end

  filter :email
  filter :name

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :user
    end
    f.actions
  end

  permit_params :email, :name, :user_id
end
