# frozen_string_literal: true

ActiveAdmin.register Aim do
  permit_params :description

  index do
    selectable_column
    id_column
    column :description
    actions
  end

  filter :description

  form do |f|
    f.inputs do
      f.input :description
    end
    f.actions
  end

  show do
     attributes_table do
       row :id
       row :description
    end
  end
end
