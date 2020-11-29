# frozen_string_literal: true

ActiveAdmin.register Credential do
  # === INDEX ===
  index do
    column :identifier
    column :exchange do |credential|
      credential.exchange&.identifier
    end
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
    end
  end

  # === FORM ===
  # form do |f|
  #   f.inputs do
  #     f.input :enabled
  #   end
  #   f.actions
  # end

  # === PERMIT PARAMS ===
  # permit_params :enabled
end
