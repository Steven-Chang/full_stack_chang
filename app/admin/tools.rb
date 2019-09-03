# frozen_string_literal: true

ActiveAdmin.register Tool do
  # === INDEX ===

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :name
      row :category
    end
  end

  # === PERMIT PARAMS ===
  permit_params :name,
                :category
end
