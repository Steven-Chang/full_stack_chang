class FscPrefix < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :achievements, name: "achievements_project_id_fk"
    remove_foreign_key :credentials, name: "credentials_exchange_id_fk"
    remove_foreign_key :orders, name: "orders_trade_pair_id_fk"
    remove_foreign_key "orders", column: :order_id
    remove_foreign_key :payment_summaries, name: "payment_summaries_client_id_fk"
    remove_foreign_key :projects_tools, name: "projects_tools_project_id_fk"
    remove_foreign_key :projects_tools, name: "projects_tools_tool_id_fk"
    remove_foreign_key :scheduled_tranxaction_templates, name: "scheduled_tranxaction_templates_creditor_id_fk"
    remove_foreign_key :scheduled_tranxaction_templates, name: "scheduled_tranxaction_templates_tax_category_id_fk"
    remove_foreign_key :tenancy_agreements, name: "tenancy_agreements_property_id_fk"
    remove_foreign_key :tenancy_agreements, name: "tenancy_agreements_user_id_fk"
    remove_foreign_key :trade_pairs, column: :credential_id
    remove_foreign_key :tranxactions, name: "tranxactions_creditor_id_fk"
    remove_foreign_key :tranxactions, name: "tranxactions_tax_category_id_fk"

    rename_index :achievements, 'index_achievements_on_project_id', 'fsc_ind_achievements_on_project_id'
    rename_index :active_admin_comments, 'index_active_admin_comments_on_author_type_and_author_id', 'fsc_ind_active_admin_comments_on_author_type_and_author_id'
    rename_index :active_admin_comments, 'index_active_admin_comments_on_namespace', 'fsc_ind_active_admin_comments_on_namespace'
    rename_index :active_admin_comments, 'index_active_admin_comments_on_resource_type_and_resource_id', 'fsc_ind_active_admin_comments_on_resource_type_and_resource_id'
    rename_index :credentials, 'index_credentials_on_exchange_id', 'fsc_ind_credentials_on_exchange_id'
    rename_index :creditors, 'index_creditors_on_name', 'fsc_ind_creditors_on_name'
    rename_index :crypto_exchanges, 'index_crypto_exchanges_on_crypto_id', 'fsc_ind_crypto_exchanges_on_crypto_id'
    rename_index :crypto_exchanges, 'index_crypto_exchanges_on_exchange_id', 'fsc_ind_crypto_exchanges_on_exchange_id'
    rename_index :orders, 'index_orders_on_order_id', 'fsc_ind_orders_on_order_id'
    rename_index :orders, 'index_orders_on_trade_pair_id', 'fsc_ind_orders_on_trade_pair_id'
    rename_index :payment_summaries, 'index_payment_summaries_on_client_id_and_year_ending', 'fsc_ind_payment_summaries_on_client_id_and_year_ending'
    rename_index :projects_tools, 'index_projects_tools_on_project_id', 'fsc_ind_projects_tools_on_project_id'
    rename_index :projects_tools, 'index_projects_tools_on_tool_id', 'fsc_ind_projects_tools_on_tool_id'
    rename_index :scheduled_tranxaction_templates, 'index_scheduled_tranxaction_templates_on_creditor_id', 'fsc_ind_scheduled_tranxaction_templates_on_creditor_id'
    rename_index :scheduled_tranxaction_templates, 'index_scheduled_tranxaction_templates_on_tax_category_id', 'fsc_ind_scheduled_tranxaction_templates_on_tax_category_id'
    rename_index :scheduled_tranxaction_templates, 'index_tranxaction_schedules_on_tranxactable', 'fsc_ind_tranxaction_schedules_on_tranxactable'
    rename_index :tools, 'index_tools_on_name', 'fsc_ind_tools_on_name'
    rename_index :tranxactions, 'index_tranxactions_on_creditor_id', 'fsc_ind_tranxactions_on_creditor_id'
    rename_index :tranxactions, 'index_tranxactions_on_tranxactable_type_and_tranxactable_id', 'fsc_ind_tranxactions_on_tranxactable_type_and_tranxactable_id'
    rename_index :users, 'index_users_on_email', 'fsc_ind_users_on_email'
    rename_index :trade_pairs, 'index_trade_pairs_on_credential_id', 'fsc_ind_trade_pairs_on_credential_id'
    rename_index :users, 'index_users_on_reset_password_token', 'fsc_ind_users_on_reset_password_token'
    rename_index :users, 'index_users_on_username', 'fsc_ind_users_on_username'

    rename_table :achievements, :fsc_achievements
    rename_table :active_admin_comments, :fsc_active_admin_comments
    rename_table :full_stack_chang_attachments, :fsc_attachments
    rename_table :blog_posts, :fsc_blog_posts
    rename_table :clients, :fsc_clients
    rename_table :credentials, :fsc_credentials
    rename_table :creditors, :fsc_creditors
    rename_table :crypto_exchanges, :fsc_crypto_exchanges
    rename_table :cryptos, :fsc_cryptos
    rename_table :exchanges, :fsc_exchanges
    rename_table :orders, :fsc_orders
    rename_table :payment_summaries, :fsc_payment_summaries
    rename_table :projects, :fsc_projects
    rename_table :projects_tools, :fsc_projects_tools
    rename_table :properties, :fsc_properties
    rename_table :scheduled_tranxaction_templates, :fsc_scheduled_tranxaction_templates
    rename_table :tax_categories, :fsc_tax_categories
    rename_table :tenancy_agreements, :fsc_tenancy_agreements
    rename_table :tools, :fsc_tools
    rename_table :trade_pairs, :fsc_trade_pairs
    rename_table :tranxactions, :fsc_tranxactions
    rename_table :users, :fsc_users
  end
end
