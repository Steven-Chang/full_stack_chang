# frozen_string_literal: true

ActiveAdmin.register Property do
  permit_params :address

  index do
    selectable_column
    id_column
    column :address
    actions
  end

  filter :address

  form do |f|
    f.inputs do
      f.input :address
    end
    f.actions
  end

  show do
     attributes_table do
       row :id
       row :address
    end
  end
end
