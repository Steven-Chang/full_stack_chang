class AllPostFscPrefix < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "fsc_achievements", "fsc_projects", column: "project_id", name: "fsc_achievements_project_id_fk"
    add_foreign_key "fsc_credentials", "fsc_exchanges", column: "exchange_id", name: "fsc_credentials_exchange_id_fk"
    add_foreign_key "fsc_orders", "fsc_orders", column: "order_id", name: "fsc_orders_order_id_fk"
    add_foreign_key "fsc_orders", "fsc_trade_pairs", column: "trade_pair_id", name: "fsc_orders_trade_pair_id_fk"
    add_foreign_key "fsc_payment_summaries", "fsc_clients", column: "client_id", name: "fsc_payment_summaries_client_id_fk"
    add_foreign_key "fsc_projects_tools", "fsc_projects", column: "project_id", name: "fsc_projects_tools_project_id_fk"
    add_foreign_key "fsc_projects_tools", "fsc_tools", column: "tool_id", name: "fsc_projects_tools_tool_id_fk"
    add_foreign_key "fsc_scheduled_tranxaction_templates", "fsc_creditors", column: "creditor_id", name: "fsc_scheduled_tranxaction_templates_creditor_id_fk"
    add_foreign_key "fsc_scheduled_tranxaction_templates", "fsc_tax_categories", column: "tax_category_id", name: "fsc_scheduled_tranxaction_templates_tax_category_id_fk"
    add_foreign_key "fsc_tenancy_agreements", "fsc_properties", column: "property_id", name: "fsc_tenancy_agreements_property_id_fk"
    add_foreign_key "fsc_tenancy_agreements", "fsc_users", column: "user_id", name: "fsc_tenancy_agreements_user_id_fk"
    add_foreign_key "fsc_trade_pairs", "fsc_credentials", column: "credential_id", name: "fsc_trade_pairs_credential_id_fk"
    add_foreign_key "fsc_tranxactions", "fsc_creditors", column: "creditor_id", name: "fsc_tranxactions_creditor_id_fk"
    add_foreign_key "fsc_tranxactions", "fsc_tax_categories", column: "tax_category_id", name: "fsc_tranxactions_tax_category_id_fk"
  end
end
