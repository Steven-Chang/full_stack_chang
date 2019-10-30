# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :medicare_number, :medicare_expiry, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :medicare_number
    column :medicare_expiry
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :medicare_number
      f.input :medicare_expiry
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
