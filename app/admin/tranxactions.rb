# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Tranxaction do
  # === INDEX ===
  config.sort_order = 'date_desc'

  index do
    column :date
    column :description
    column :amount do |tranxaction|
      number_to_currency(tranxaction.amount)
    end
    column :tax
    column :tax_category do |tranxaction|
      tranxaction&.tax_category&.description
    end
    column :creditor
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

  filter :amount
  filter :creditor, collection: lambda {
    Creditor.all.map { |creditor| [creditor.name, creditor.id] }
  }
  filter :date
  filter :description
  filter :tax
  filter :tax_category, collection: lambda {
    TaxCategory.all.map { |tax_category| [tax_category.description, tax_category.id] }
  }
  filter :tax_category_id_present, as: :boolean

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :date
      row :description
      row :amount do |tranxaction|
        number_to_currency(tranxaction.amount)
      end
      row :tax
      row :tax_category do |tranxaction|
        tranxaction&.tax_category&.description
      end
      row :creditor
      table_for tranxaction.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          link_to attachment.url, attachment.url, target: '_blank', rel: 'noopener'
        end
      end
    end
  end

  # === FORM ===
  form do |f|
    f.object.date ||= Date.current
    f.inputs do
      f.input :date, required: true
      f.input :description, required: true
      f.input :amount, required: true
      f.input :tax
      f.input :tax_category, member_label: :description
      f.input :creditor, member_label: :name
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :amount,
                :creditor_id,
                :date,
                :description,
                :tax,
                :tax_category_id,
                attachments_attributes: %i[url aws_key]
end
