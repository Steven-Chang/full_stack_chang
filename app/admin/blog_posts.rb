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

  form do |f|
    f.inputs do
      f.input :date_added
      f.input :description
      f.input :image_url
      f.input :private
      f.input :title
      f.input :youtube_url
    end
    f.actions
  end
end
