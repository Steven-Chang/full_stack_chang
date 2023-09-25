# frozen_string_literal: true

ActiveAdmin.register Tool do
  # === MENU ===
  menu parent: 'Personal'

  # === INDEX ===
  index do
    column :name
    column :category
    column :visible
    column :logo do |tool|
      next if tool.logo.blank?

      image_tag tool.logo.variant(:thumb).processed
    end
    actions
  end

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :visible
      row :logo do |tool|
        next if tool.logo.blank?

        image_tag tool.logo
      end
      table_for tool.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          # Permanent
          link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener'
          # Temporary
          # link_to "Download", rails_blob_path(attachment, disposition: 'attachment'), target: '_blank', rel: 'noopener'
        end
      end
    end
    active_admin_comments
  end

  # === FORM ===
  form(html: { autocomplete: :off }) do |f|
    f.inputs do
      f.input :logo, as: :file, input_html: { value: f.object.logo.signed_id }
      f.input :name
      f.input :category
      f.input :visible
      f.object.attachments.each do |attachment|
        f.input :attachments, input_html: { multiple: true, value: attachment.signed_id }, as: :hidden
      end
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :name,
                :category,
                :visible,
                :logo,
                attachments: []
end
