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
    column :attachments
    actions
  end

  filter :amount
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
      row :attachments
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
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :amount,
                :date,
                :description,
                :tax,
                :tax_category_id,
                attachments_attributes: %i[url aws_key]
end
