# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register ScheduledTranxactionTemplate do
  # === MENU ===
  menu parent: 'Taxes'

  # === INDEX ===
  index do
    id_column
    column :date
    column :date_offset
    column :description
    column :amount do |scheduled_tranxaction_template|
      number_to_currency(scheduled_tranxaction_template.amount)
    end
    column :days_for_recurrence
    column :enabled
    column :tax
    column :tax_category do |scheduled_tranxaction_template|
      scheduled_tranxaction_template&.tax_category&.description
    end
    column 'Tranxactable' do |scheduled_tranxaction_template|
      next if scheduled_tranxaction_template.tranxactable.blank?

      link_description = "#{scheduled_tranxaction_template.tranxactable.class}: "
      if scheduled_tranxaction_template.tranxactable.class == TenancyAgreement
        link_description += scheduled_tranxaction_template.tranxactable.user.username
      elsif scheduled_tranxaction_template.tranxactable.class == Client
        link_description += scheduled_tranxaction_template.tranxactable.name
      elsif scheduled_tranxaction_template.tranxactable.class == Property
        link_description += scheduled_tranxaction_template.tranxactable.address
      end
      url = "/admin/#{scheduled_tranxaction_template.tranxactable.class.to_s.underscore.pluralize}/#{scheduled_tranxaction_template.tranxactable.id}"
      link_to link_description, url
    end
    column :creditor
    actions
  end

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :date
      row :date_offset
      row :description
      row :amount do |scheduled_tranxaction_template|
        number_to_currency(scheduled_tranxaction_template.amount)
      end
      row :days_for_recurrence
      row :enabled
      row :tax
      row :tax_category do |scheduled_tranxaction_template|
        scheduled_tranxaction_template&.tax_category&.description
      end
      row :tranxactable do |scheduled_tranxaction_template|
        next if scheduled_tranxaction_template.tranxactable.blank?

        link_description = "#{scheduled_tranxaction_template.tranxactable.class}: "
        if scheduled_tranxaction_template.tranxactable.class == TenancyAgreement
          link_description += scheduled_tranxaction_template.tranxactable.user.username
        elsif scheduled_tranxaction_template.tranxactable.class == Client
          link_description += scheduled_tranxaction_template.tranxactable.name
        elsif scheduled_tranxaction_template.tranxactable.class == Property
          link_description += scheduled_tranxaction_template.tranxactable.address
        end
        url = "/admin/#{scheduled_tranxaction_template.tranxactable.class.to_s.underscore.pluralize}/#{scheduled_tranxaction_template.tranxactable.id}"
        link_to link_description, url
      end
      row :creditor
    end
  end

  # === FORM ===
  form do |f|
    f.object.date ||= Date.current
    f.inputs do
      f.input :date, required: true
      f.input :date_offset, required: false
      f.input :description, required: true
      f.input :amount, required: true
      f.input :days_for_recurrence, required: true
      f.input :enabled
      f.input :tax
      f.input :tax_category, member_label: :description
      f.input :tranxactable_type, collection: %w[Client Property TenancyAgreement]
      f.input :tranxactable_id, as: :select,
                                collection: (Client.all.map { |client| [client.name, client.id] } +
                                            Property.all.map { |property| [property.address, property.id] } +
                                            TenancyAgreement.all.map do |tenancy_agreement|
                                              [tenancy_agreement.user.username || tenancy_agreement.user.email, tenancy_agreement.id]
                                            end)
      f.input :creditor, member_label: :name, collection: Creditor.order('LOWER(name)')
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :amount,
                :creditor_id,
                :date,
                :date_offset,
                :days_for_recurrence,
                :description,
                :enabled,
                :tax,
                :tax_category_id,
                :tranxactable_type,
                :tranxactable_id
end
