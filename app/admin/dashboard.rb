# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    Tranxaction.end_of_financial_year_dates_ordered_descending_for_dashboard.each do |end_of_financial_year_date|
      panel "#{end_of_financial_year_date.year - 1}-#{end_of_financial_year_date.year}" do
        render partial: 'active_admin/dashboard/tranxactable_types',
               locals: {
                 tranxactable_type: 'Client',
                 end_of_financial_year_date: end_of_financial_year_date
               }
        render partial: 'active_admin/dashboard/tranxactable_types',
               locals: {
                 tranxactable_type: 'Property',
                 end_of_financial_year_date: end_of_financial_year_date
               }
        render partial: 'active_admin/dashboard/tranxactable_types',
               locals: {
                 tranxactable_type: 'TenancyAgreement',
                 end_of_financial_year_date: end_of_financial_year_date
               }

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
