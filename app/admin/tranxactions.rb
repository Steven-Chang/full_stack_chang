# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Tranxaction do
  # === MENU ===
  menu parent: 'Taxes'

  # === INDEX ===
  config.sort_order = 'date_desc'

  # scopes
  scope :all
  scope :steven, default: true
  scope :emily

  index do
    id_column
    column :date
    column :description
    column :amount do |tranxaction|
      number_to_currency(tranxaction.amount)
    end
    column :tax
    column :tax_category do |tranxaction|
      tranxaction&.tax_category&.description
    end
    column 'Tranxactable' do |tranxaction|
      next if tranxaction.tranxactable.blank?

      link_description = "#{tranxaction.tranxactable.class}: "
      if tranxaction.tranxactable.instance_of?(TenancyAgreement)
        link_description += tranxaction.tranxactable.user.username
      elsif tranxaction.tranxactable.instance_of?(Client)
        link_description += tranxaction.tranxactable.name
      elsif tranxaction.tranxactable.instance_of?(Property)
        link_description += tranxaction.tranxactable.address
      end
      url = "/admin/#{tranxaction.tranxactable.class.to_s.underscore.pluralize}/#{tranxaction.tranxactable.id}"
      link_to link_description, url
    end
    column :creditor
    column :attachments do |tranxaction|
      tranxaction.attachments
                 .map { |attachment| link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener' }
                 .join
                 .html_safe
    end
    actions
  end

  filter :amount
  filter :date
  filter :description
  filter :creditor
  filter :tax
  filter :tax_category
  filter :tranxactable_type, collection: %w[Client Property TenancyAgreement]
  filter :tranxactable_id, as: :select,
                           collection: proc {
                             Client.all.map { |client| [client.name, client.id] } +
                               Property.all.map { |property| [property.address, property.id] } +
                               TenancyAgreement.all.map do |tenancy_agreement|
                                 [tenancy_agreement.reference, tenancy_agreement.id]
                               end
                           }

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
      row :tax_category
      row :tranxactable do |tranxaction|
        next if tranxaction.tranxactable.blank?

        link_description = "#{tranxaction.tranxactable.class}: "
        if tranxaction.tranxactable.instance_of?(TenancyAgreement)
          link_description += tranxaction.tranxactable.user.username
        elsif tranxaction.tranxactable.instance_of?(Client)
          link_description += tranxaction.tranxactable.name
        elsif tranxaction.tranxactable.instance_of?(Property)
          link_description += tranxaction.tranxactable.address
        end
        url = "/admin/#{tranxaction.tranxactable.class.to_s.underscore.pluralize}/#{tranxaction.tranxactable.id}"
        link_to link_description, url
      end
      row :creditor
      row :user
      row :attachments do |tranxaction|
        tranxaction.attachments
                   .map { |attachment| link_to attachment.filename.to_s, url_for(attachment), target: '_blank', rel: 'noopener' }
                   .join
                   .html_safe
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
      f.input :tax_category
      f.input :tranxactable_type, collection: %w[Client]
      f.input :tranxactable_id, as: :select, collection: Client.all.map { |client| [client.display_name, client.id] }
      # + Property.all.map { |property| [property.address, property.id] } + TenancyAgreement.all.map { |tenancy_agreement| [tenancy_agreement.reference, tenancy_agreement.id] }, wrapper_html: { style: 'display: none;' }
      f.input :creditor
      f.input :user
      f.object.attachments.each do |attachment|
        f.input :attachments, input_html: { multiple: true, value: attachment.signed_id }, as: :hidden
      end
      f.input :attachments, as: :file, input_html: { multiple: true }
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
                :tranxactable_type,
                :tranxactable_id,
                :user_id,
                attachments: []
end
