# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  # === MENU ===
  menu parent: 'Crypto', priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    render partial: 'active_admin/dashboard/crypto_dashboard'
  end
end
