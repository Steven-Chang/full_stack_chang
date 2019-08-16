# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    Tranxaction.end_of_financial_year_dates_ordered_descending_for_dashboard.each do |end_of_financial_year_date|
      panel "#{end_of_financial_year_date.year - 1}-#{end_of_financial_year_date.year}" do
        h3 'Clients'
        table_for Tranxaction.tranxactables_with_tranxactions('Client', end_of_financial_year_date - 1.year + 1.day, end_of_financial_year_date, true) do
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
        table_for Tranxaction.tranxactables_with_tranxactions('Property', end_of_financial_year_date - 1.year + 1.day, end_of_financial_year_date, true) do
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
    
        Client.all.map do |client|
          h4 "#{client.name} expenses by tax categories"
          client.tranxactions
                .where('date >= ?', end_of_financial_year_date - 1.year + 1.day)
                .where('date <= ?', end_of_financial_year_date)
                .where('amount < 0')
                .where(tax: true)
                .select(:tax_category_id,
                         'SUM(amount) as sum_amount',
                         'COUNT(*) as tranxactions_count')
                .group(:tax_category_id)
                .map do |g|
            li "#{TaxCategory.find(g.tax_category_id).description if g.tax_category_id}(#{g.tranxactions_count}): #{number_to_currency(g.sum_amount)}"
          end
          hr
        end

        h4 'Property expenses by tax categories'
        Tranxaction.where('date >= ?', end_of_financial_year_date - 1.year + 1.day)
                   .where('date <= ?', end_of_financial_year_date)
                   .where('amount < 0')
                   .where(tax: true)
                   .where(tranxactable_type: 'Property')
                   .select(:tax_category_id,
                           'SUM(amount) as sum_amount',
                           'COUNT(*) as tranxactions_count')
                   .group(:tax_category_id)
                   .map do |g|
          li "#{TaxCategory.find(g.tax_category_id).description if g.tax_category_id}(#{g.tranxactions_count}): #{number_to_currency(g.sum_amount)}"
        end

        hr

        h4 'Tenancy agreement expenses by tax categories'
        Tranxaction.where('date >= ?', end_of_financial_year_date - 1.year + 1.day)
                   .where('date <= ?', end_of_financial_year_date)
                   .where('amount < 0')
                   .where(tax: true)
                   .where(tranxactable_type: 'TenancyAgreement')
                   .select(:tax_category_id,
                           'SUM(amount) as sum_amount',
                           'COUNT(*) as tranxactions_count')
                   .group(:tax_category_id)
                   .map do |g|
          li "#{TaxCategory.find(g.tax_category_id).description if g.tax_category_id}(#{g.tranxactions_count}): #{number_to_currency(g.sum_amount)}"
        end

        hr

        h4 'Expense tranxactions that are not Clients, TenancyAgreement or Property'
        Tranxaction.where('date >= ?', end_of_financial_year_date - 1.year + 1.day)
                   .where('date < ?', end_of_financial_year_date)
                   .where('amount < 0')
                   .where(tax: true)
                   .where.not(tranxactable_type: 'Client')
                   .where.not(tranxactable_type: 'TenancyAgreement')
                   .where.not(tranxactable_type: 'Property')
                   .select(:tax_category_id,
                           'SUM(amount) as sum_amount',
                           'COUNT(*) as tranxactions_count')
                   .group(:tax_category_id)
                   .map do |g|
          li "#{TaxCategory.find(g.tax_category_id).description}(#{g.tranxactions_count}): #{number_to_currency(g.sum_amount)}"
        end
      end
    end
  end
end
