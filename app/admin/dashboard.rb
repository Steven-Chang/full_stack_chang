# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    h5 '*Other tranxactions: No direct association with Client, Property or TenancyAgreement'
    Tranxaction.end_of_financial_year_dates_ordered_descending_for_dashboard&.slice(0, 1)&.each do |end_of_financial_year_date|
      panel "#{end_of_financial_year_date.year - 1}-#{end_of_financial_year_date.year}" do
        render partial: 'active_admin/dashboard/summary',
               locals: {
                 end_of_financial_year_date: end_of_financial_year_date
               }
        render partial: 'active_admin/dashboard/tranxactions',
               locals: {
                 tranxactions: Tranxaction.filter(nil, end_of_financial_year_date - 1.year + 1.day, end_of_financial_year_date, nil, nil, true).where.not(tranxactable_type: %w[Client Property TenancyAgreement]),
                 title: 'Other tranxactions'
               }
        render partial: 'active_admin/dashboard/tax_categories',
               locals: {
                 end_of_financial_year_date: end_of_financial_year_date
               }
      end
    end
  end
end
