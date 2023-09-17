# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Project do
  # === MENU ===
  menu parent: 'Personal'

  # === INDEX ===
  index do
    column :title
    column :url do |project|
      link_to 'link', project.url
    end
    column :start_date
    column :end_date
    column :private
    column :logo do |project|
      next if project.logo.blank?

      image_tag project.logo
    end
    actions
  end

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :title
      row :description
      row :url do |project|
        link_to 'link', project.url
      end
      row :start_date
      row :end_date
      row :private
      row :logo do |project|
        next if project.logo.blank?

        image_tag project.logo
      end
    end
  end

  # === FORM ===
  form do |f|
    f.inputs do
      f.input :logo, as: :file
      f.input :title, required: true
      f.input :description
      f.input :url
      f.input :role
      f.input :start_date
      f.input :end_date
      f.input :private
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :description,
                :end_date,
                :private,
                :role,
                :start_date,
                :title,
                :url,
                :logo
end
