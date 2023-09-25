# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register BlogPost do
  # === CONFIG ===
  config.batch_actions = false
  config.sort_order = 'date_added_desc'

  # === MENU ===
  menu parent: 'Personal'

  # === INDEX ===
  index as: :blog, download_links: false do
    title do |blog_post|
      span blog_post.title, class: 'title'
    end
    body do |blog_post|
      div do
        div blog_post.date_added.strftime('%d %B %Y'), class: 'date_added'
        div(style: 'white-space: pre-wrap;') do
          blog_post.description
        end

        blog_post.attachments do |attachment|
          link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener'
        end
      end
    end
    # column :private
  end

  filter :date_added
  filter :description
  filter :private
  filter :title

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :title
      row :date_added
      row :description
      row :private
      table_for blog_post.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener'
        end
      end
    end
  end

  # === FORM ===
  form(html: { autocomplete: :off }) do |f|
    f.object.date_added ||= DateTime.current
    f.inputs do
      f.input :title
      f.input :date_added, start_year: 1985
      f.input :description
      f.input :private
      f.object.attachments.each do |attachment|
        f.input :attachments, input_html: { multiple: true, value: attachment.signed_id }, as: :hidden
      end
      f.input :attachments, as: :file, input_html: { multiple: true }
      li '<label>Cloudinary upload</label><button id="upload_widget" class="cloudinary-button">Upload image</button>'.html_safe
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :date_added,
                :description,
                :private,
                :title,
                attachments: []
end
