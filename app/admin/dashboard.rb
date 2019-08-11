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

    # Here is an example of a simple dashboard with columns and panels.

    columns do
      column do
        panel '18-19 Gross Income' do
          ul do
            Client.all.map do |client|
              li "#{client.name}: $#{client.tranxactions
                                           .where('date >= ?', Date.new(2018, 7, 1))
                                           .where('date < ?', Date.new(2019, 7, 1))
                                           .where('amount > 0')
                                           .where(tax: true)
                                           .sum(:amount)}"
            end
            li "Rent: $#{Tranxaction.where('date >= ?', Date.new(2018, 7, 1))
                                    .where('date < ?', Date.new(2019, 7, 1))
                                    .where('amount > 0')
                                    .where(tranxactable_type: 'TenancyAgreement')
                                    .where(tax: true)
                                    .sum(:amount)}"
            Tranxaction.where('date >= ?', Date.new(2018, 7, 1))
                       .where('date < ?', Date.new(2019, 7, 1))
                       .where('amount > 0')
                       .where(tax: true)
                       .where.not(tranxactable_type: 'Client')
                       .where.not(tranxactable_type: 'TenancyAgreement')
                       .map do |tranxaction|
              li "#{tranxaction.description}: $#{tranxaction.amount}"
            end
          end
        end
      end

      column do
        panel 'Info' do
          para 'Welcome to ActiveAdmin.'
        end
      end
    end
  end
end
