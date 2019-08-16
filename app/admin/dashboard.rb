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
      h2 "#{end_of_financial_year_date.year - 1}-#{end_of_financial_year_date.year}"
      columns do
        column do
          panel 'Revenue' do
            h3 'Clients'
            table_for Client.all do
              column 'Name', :column
              column '$' do |client|
                number_to_currency(Tranxaction.balance(client,
                                                       end_of_financial_year_date - 1.year + 1.day,
                                                       end_of_financial_year_date,
                                                       0,
                                                       nil,
                                                       true))
              end
            end

            h3 'TenancyAgreement'
            table_for TenancyAgreement.all do
              column 'Username', :column
              column '$' do |tenancy_agreement|
                number_to_currency(Tranxaction.balance(tenancy_agreement,
                                                       end_of_financial_year_date - 1.year + 1.day,
                                                       end_of_financial_year_date,
                                                       0,
                                                       nil,
                                                       true))
              end
            end

            h3 'Incoming tranxactions that are not related to Clients or TenancyAgreements'
            ul do
              Tranxaction.filter(nil, end_of_financial_year_date - 1.year + 1.day, end_of_financial_year_date, 0, nil, true)
                         .where.not(tranxactable_type: 'Client')
                         .where.not(tranxactable_type: 'TenancyAgreement')
                         .map do |tranxaction|
                li "#{tranxaction.description}: $#{tranxaction.amount}"
              end
            end
          end
        end

        column do
          panel 'Expenses' do
            h3 'Clients'
            Client.all.map do |client|
              li "#{client.name}: #{number_to_currency(client.tranxactions
                                                             .where('date >= ?', Date.new(2018, 7, 1))
                                                             .where('date < ?', Date.new(2019, 7, 1))
                                                             .where('amount < 0')
                                                             .where(tax: true)
                                                             .sum(:amount))}"
              h4 "#{client.name} expenses by tax categories"
              client.tranxactions
                    .where('date >= ?', Date.new(2018, 7, 1))
                    .where('date < ?', Date.new(2019, 7, 1))
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

            h3 'TenancyAgreement'
            li number_to_currency(Tranxaction.where('date >= ?', Date.new(2018, 7, 1))
                                             .where('date < ?', Date.new(2019, 7, 1))
                                             .where('amount < 0')
                                             .where(tranxactable_type: 'TenancyAgreement')
                                             .where(tax: true)
                                             .sum(:amount))

            h3 'Property'
            li number_to_currency(Tranxaction.where('date >= ?', Date.new(2018, 7, 1))
                                            .where('date < ?', Date.new(2019, 7, 1))
                                            .where('amount < 0')
                                            .where(tranxactable_type: 'Property')
                                            .where(tax: true)
                                            .sum(:amount))
            h4 'Property expenses by tax categories'
            Tranxaction.where('date >= ?', Date.new(2018, 7, 1))
                       .where('date < ?', Date.new(2019, 7, 1))
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

            h3 'Expense tranxactions that are not Clients, TenancyAgreement or Property'
            Tranxaction.where('date >= ?', Date.new(2018, 7, 1))
                       .where('date < ?', Date.new(2019, 7, 1))
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
  end
end
