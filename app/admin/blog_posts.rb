# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register BlogPost do
  # === INDEX ===
  index do
    column :date_added
    column :title
    column :description
    column :private
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
      row 'Images' do |blog_post|
        html = ''
        blog_post.attachments.where(file_type: 0).each do |attachment|
          html += "<img src=#{attachment.url}>"
        end
        html.html_safe
      end
    end
  end

  # === FORM ===
  form(html: { autocomplete: :off }) do |f|
    f.object.date_added ||= DateTime.current
    f.inputs do
      f.input :title
      f.input :date_added
      f.input :description
      f.input :private
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :description, :private, :title, :date_added
end
