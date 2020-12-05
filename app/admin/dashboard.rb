# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    h4 'Average minutes to scalp'
    div do
      line_chart minutes_to_sale_path
    end
  end
end
