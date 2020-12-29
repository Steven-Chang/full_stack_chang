# frozen_string_literal: true

ActiveAdmin.register Credential do
  # === ACTIONS ===
  actions :index, :show

  # === SCOPES ===
  scope :all
  scope :enabled, default: true

  # === INDEX ===
  index do
    column :identifier
    column :exchange do |credential|
      credential.exchange&.identifier
    end
    column :enabled
    actions
  end

  filter :identifier

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :identifier
      row :exchange do |credential|
        credential.exchange&.identifier
      end
      row :enabled
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :identifier
      f.input :exchange, member_label: :identifier, collection: Exchange.order('LOWER(identifier)'), include_blank: false
      f.input :enabled
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :enabled, :exchange_id, :identifier
end
