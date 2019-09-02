# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Project do
  # === INDEX ===
  index do
    column :title
    column :url do |project|
      link_to 'link', project.url
    end
    column :start_date
    column :end_date
    column :private
    column :attachments do |tranxaction|
      next if tranxaction.attachments.blank?

      table_for tranxaction.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          link_to attachment.url, attachment.url, target: '_blank', rel: 'noopener'
        end
      end
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
      table_for project.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          link_to attachment.url, attachment.url, target: '_blank', rel: 'noopener'
        end
      end
    end
  end

  # === PERMIT PARAMS ===
  permit_params :description,
                :end_date,
                :name,
                :private,
                :role,
                :start_date,
                :title,
                :url
end
