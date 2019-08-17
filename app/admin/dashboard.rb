# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    Tranxaction.end_of_financial_year_dates_ordered_descending_for_dashboard.each do |end_of_financial_year_date|
      panel "#{end_of_financial_year_date.year - 1}-#{end_of_financial_year_date.year}" do
        render partial: 'active_admin/dashboard/summary',
               locals: {
                 end_of_financial_year_date: end_of_financial_year_date
               }
        render partial: 'active_admin/dashboard/tranxactions',
               locals: {
                 tranxactions: Tranxaction.filter(nil, end_of_financial_year_date - 1.year + 1.day, end_of_financial_year_date, nil, nil, true).where.not(tranxactable_type: %w[Client Property TenancyAgreement]),
                 title: "Tranxactions that aren't associated with clients, properties or tenancy agreements"
               }
    
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
      end
    end
  end
end
