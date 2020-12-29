# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register PaymentSummary do
  # === INDEX ===
  config.sort_order = 'year_ending_desc'

  # === MENU ===
  menu parent: 'Taxes'

  index do
    column :year_ending
    column :client do |payment_summary|
      payment_summary.client.name
    end
    column :total_tax_withheld
    column :total_allowances
    actions
  end

  filter :year_ending, as: :select, collection: lambda {
    PaymentSummary.pluck(:year_ending).uniq
  }
  filter :client, collection: lambda {
    Client.all.map { |client| [client.name, client.id] }
  }

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :year_ending
      row :client do |payment_summary|
        payment_summary.client.name
      end
      row :total_tax_withheld do |payment_summary|
        number_to_currency(payment_summary.total_tax_withheld)
      end
      row :total_allowances do |payment_summary|
        number_to_currency(payment_summary.total_allowances)
      end
    end
  end

  # === FORM ===
  form do |f|
    f.object.year_ending ||= Date.current.year
    f.inputs do
      f.input :year_ending, required: true
      f.input :client, member_label: :name,
                       include_blank: false,
                       required: true
      f.input :total_tax_withheld
      f.input :total_allowances
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :client_id,
                :total_allowances,
                :total_tax_withheld,
                :year_ending,
                attachments_attributes: %i[url aws_key]
end
