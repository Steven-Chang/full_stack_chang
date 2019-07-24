# frozen_string_literal: true

ActiveAdmin.register BlogPost do
  permit_params :description, :image_url, :private, :title, :youtube_url, :date_added

  index do
    selectable_column
    id_column
    column :date_added
    column :description
    column :private
    column :title
    column :youtube_url
    actions
  end

  filter :date_added
  filter :private

  show do
    attributes_table do
      row :id
      row :title
      row :date_added
      row :description
      row :image_url
      row :youtube_url
      row :private
    end
  end

  form do |f|
    f.object.date_added ||= DateTime.current
    f.inputs do
      f.input :title
      f.input :date_added
      f.input :description
      f.input :image_url
      f.input :youtube_url
      f.input :private
    end
    f.actions
  end
end
