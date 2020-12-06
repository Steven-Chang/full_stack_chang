# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    panel 'Average minutes to scalp' do
      line_chart minutes_to_sale_path, xtitle: 'Date scalp order created', ytitle: 'Minutes to fill scalp order'
    end

    panel 'Total scalped' do
      line_chart total_scalped_path, xtitle: 'Date scalp order created', ytitle: '# of scalp orders'
    end
  end
end
