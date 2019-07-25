# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register TenancyAgreement do
  before_action only: :index do
    params['q'] = { active_eq: true } if params['commit'].blank?
  end

  # === INDEX ===
  index do
    column :balance do |tenancy_agreement|
      number_to_currency(tenancy_agreement.balance)
    end
    column :user do |tenancy_agreement|
      link_to tenancy_agreement.user.email, [:admin, tenancy_agreement]
    end
    column :property do |tenancy_agreement|
      link_to tenancy_agreement.property.address, [:admin, tenancy_agreement]
    end
    column :starting_date
    column :amount do |tenancy_agreement|
      number_to_currency(tenancy_agreement.amount)
    end
    column :bond do |tenancy_agreement|
      number_to_currency(tenancy_agreement.bond)
    end
    column :active
    column :tax
    actions
  end

  filter :active, default: true
  filter :property

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :user do |tenancy_agreement|
        tenancy_agreement.user.email
      end
      row :property do |tenancy_agreement|
        tenancy_agreement.property.address
      end
      row :starting_date
      row :amount
      row :bond
      row :active
      row :tax
    end
  end

  # === FORM ===
  form do |f|
    f.object.starting_date ||= Date.current
    f.inputs do
      f.input :user, member_label: :email,
                     include_blank: false,
                     required: true
      f.input :property, member_label: :address,
                         include_blank: false,
                         required: true
      f.input :starting_date
      f.input :amount
      f.input :bond
      f.input :active
      f.input :tax
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :amount,
                :starting_date,
                :user_id,
                :property_id,
                :bond,
                :active,
                :tax
end
