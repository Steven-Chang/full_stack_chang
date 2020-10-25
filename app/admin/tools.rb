# frozen_string_literal: true

ActiveAdmin.register Tool do
  # === INDEX ===

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :name
      row :category
      row :visible
      row 'Images' do |tool|
        out = []
        tool.attachments.where(file_type: 0).each do |attachment|
          out << cl_image_tag(attachment.cloudinary_public_id) if attachment.cloudinary_public_id.present?
        end
        safe_join(out)
      end
    end
    active_admin_comments
  end

  # === FORM ===
  form(html: { autocomplete: :off }) do |f|
    f.inputs do
      f.input :name
      f.input :category
      f.input :visible
      f.has_many :attachments,
                 heading: 'Attachments',
                 new_record: 'Manually create an attachment',
                 allow_destroy: true do |a|
        a.input :cloudinary_public_id
        a.object.file_type = 'image'
        a.input :file_type, as: :select,
                            collection: Attachment.file_types.keys,
                            include_blank: false
      end
      li '<label>Cloudinary upload</label><button id="upload_widget" class="cloudinary-button">Upload image</button>'.html_safe
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :name,
                :category,
                :visible,
                attachments_attributes: %i[id name cloudinary_public_id file_type _destroy]
end
