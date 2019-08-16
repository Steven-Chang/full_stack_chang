# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    # div class: 'blank_slate_container', id: 'dashboard_default_message' do
    #   span class: 'blank_slate' do
    #     span I18n.t('active_admin.dashboard_welcome.welcome')
    #     small I18n.t('active_admin.dashboard_welcome.call_to_action')
    #   end
    # end

    Tranxaction.end_of_financial_year_dates_ordered_descending_for_dashboard.each do |end_of_financial_year_date|
      panel "#{end_of_financial_year_date.year - 1}-#{end_of_financial_year_date.year}" do
        h3 'Clients'
        table_for Client.all do
          column :name
          column 'revenue' do |client|
            number_to_currency(Tranxaction.balance(client,
                                                   end_of_financial_year_date - 1.year + 1.day,
                                                   end_of_financial_year_date,
                                                   0,
                                                   nil,
                                                   true))
          end
          column 'expenses' do |client|
            number_to_currency(Tranxaction.balance(client,
                                                   end_of_financial_year_date - 1.year + 1.day,
                                                   end_of_financial_year_date,
                                                   nil,
                                                   0,
                                                   true))
          end
          column 'net' do |client|
            number_to_currency(Tranxaction.balance(client,
                                                   end_of_financial_year_date - 1.year + 1.day,
                                                   end_of_financial_year_date,
                                                   nil,
                                                   nil,
                                                   true))
          end
        end

        h3 'Property(including TenancyAgreement)'
        table_for Property.all do
          column :address
          column 'revenue' do |property|
            total = 0
            t = Tranxaction.filter(nil,
                                   end_of_financial_year_date - 1.year + 1.day,
                                   end_of_financial_year_date,
                                   0,
                                   nil,
                                   true)
            total += t.where(tranxactable_type: 'Property').where(tranxactable_id: property.id).sum(:amount)
            property.tenancy_agreements.each do |tenancy_agreement|
              total += t.where(tranxactable_type: 'TenancyAgreement').where(tranxactable_id: tenancy_agreement.id).sum(:amount)
            end
            number_to_currency(total)
          end
          column 'expenses' do |property|
            total = 0
            t = Tranxaction.filter(nil,
                                   end_of_financial_year_date - 1.year + 1.day,
                                   end_of_financial_year_date,
                                   nil,
                                   0,
                                   true)
            total += t.where(tranxactable_type: 'Property')
                      .where(tranxactable_id: property.id)
                      .sum(:amount)
            property.tenancy_agreements.each do |tenancy_agreement|
              total += t.where(tranxactable_type: 'TenancyAgreement')
                        .where(tranxactable_id: tenancy_agreement.id)
                        .sum(:amount)
            end
            number_to_currency(total)
          end
          column 'net' do |property|
            total = 0
            t = Tranxaction.filter(nil,
                                   end_of_financial_year_date - 1.year + 1.day,
                                   end_of_financial_year_date,
                                   nil,
                                   nil,
                                   true)
            total += t.where(tranxactable_type: 'Property').where(tranxactable_id: property.id).sum(:amount)
            property.tenancy_agreements.each do |tenancy_agreement|
              total += t.where(tranxactable_type: 'TenancyAgreement').where(tranxactable_id: tenancy_agreement.id).sum(:amount)
            end
            number_to_currency(total)
          end
        end

        h3 'Incoming tranxactions that are not related to Clients, Properties or TenancyAgreements'
        ul do
          Tranxaction.filter(nil, end_of_financial_year_date - 1.year + 1.day, end_of_financial_year_date, 0, nil, true)
                     .where.not(tranxactable_type: 'Client')
                     .where.not(tranxactable_type: 'Property')
                     .where.not(tranxactable_type: 'TenancyAgreement')
                     .map do |tranxaction|
            li "#{tranxaction.description}: $#{tranxaction.amount}"
          end
        end
      end
    end
  end
end
