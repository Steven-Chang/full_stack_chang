# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register PaymentSummary do
  # === MENU ===
  menu parent: 'Taxes'

  # === INDEX ===
  config.sort_order = 'year_ending_desc'

  # scopes
  scope :all
  scope :steven, default: true
  scope :emily

  index do
    column :year_ending
    column :client do |payment_summary|
      "#{payment_summary.user.username}: #{payment_summary.client.name}"
    end
    column :total_tax_withheld
    column :total_allowances
    column :attachments do |payment_summary|
      next if payment_summary.attachments.blank?

      table_for payment_summary.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener'
        end
      end
    end
    actions
  end

  filter :year_ending, as: :select, collection: lambda {
    PaymentSummary.pluck(:year_ending).uniq
  }
  filter :client, collection: lambda {
    Client.all.map { |client| ["#{client.user.username}: #{client.name}", client.id] }
  }

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :year_ending
      row :client do |payment_summary|
        "#{payment_summary.user.username}: #{payment_summary.client.name}"
      end
      row :total_tax_withheld do |payment_summary|
        number_to_currency(payment_summary.total_tax_withheld)
      end
      row :total_allowances do |payment_summary|
        number_to_currency(payment_summary.total_allowances)
      end
      table_for tranxaction.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          # Permanent
          link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener'
          # Temporary
          # link_to "Download", rails_blob_path(attachment, disposition: 'attachment'), target: '_blank', rel: 'noopener'
        end
      end
    end
  end

  # === FORM ===
  form do |f|
    f.object.year_ending ||= Date.current.year
    f.inputs do
      f.input :year_ending, required: true
      f.input :client_id, as: :select,
                          collection: Client.all.map { |client| ["#{client.user.username}: #{client.name}", client.id] }
      f.input :total_tax_withheld
      f.input :total_allowances
      f.object.attachments.each do |attachment|
        f.input :attachments, input_html: { multiple: true, value: attachment.signed_id }, as: :hidden
      end
      f.input :attachments, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :client_id,
                :total_allowances,
                :total_tax_withheld,
                :year_ending,
                attachments: []
end
