# frozen_string_literal: true

ActiveAdmin.register User do
  # === INDEX ===
  index do
    selectable_column
    id_column
    column :email
    column :username
    column :admin
    column :otp_required_for_login
    actions
  end

  filter :admin

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :email
      row :username
      row :admin
      row :location
      row :medicare_number
      row :medicare_expiry
      row :otp_required_for_login
      row :created_at
      row :updated_at
    end
  end

  # === FORMS ===
  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :admin
      f.input :location
      f.input :medicare_number
      f.input :medicare_expiry
      f.input :password
      f.input :password_confirmation
      f.input :otp_required_for_login
    end
    f.actions
  end

  permit_params :admin, :email, :location, :medicare_number, :medicare_expiry, :otp_required_for_login, :password, :password_confirmation, :username
end
