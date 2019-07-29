# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register BlogPost do
  # === INDEX ===
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

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :title
      row :date_added
      row :description
      row :private
      row :image do |blog_post|
        image_tag blog_post.image_url if blog_post.image_url
      end
      row :youtube_url
    end
  end

  # === FORM ===
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

  # === PERMIT PARAMS ===
  permit_params :description, :image_url, :private, :title, :youtube_url, :date_added
end
