class AddKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "entries", "aims", name: "entries_aim_id_fk"
    add_foreign_key "payment_summaries", "clients", name: "payment_summaries_client_id_fk"
    add_foreign_key "scheduled_tranxaction_templates", "creditors", name: "scheduled_tranxaction_templates_creditor_id_fk"
    add_foreign_key "scheduled_tranxaction_templates", "tax_categories", name: "scheduled_tranxaction_templates_tax_category_id_fk"
    add_foreign_key "scores", "projects", name: "scores_project_id_fk"
    add_foreign_key "tenancy_agreements", "properties", name: "tenancy_agreements_property_id_fk"
    add_foreign_key "tenancy_agreements", "users", name: "tenancy_agreements_user_id_fk"
    add_foreign_key "tranxactions", "creditors", name: "tranxactions_creditor_id_fk"
    add_foreign_key "tranxactions", "tax_categories", name: "tranxactions_tax_category_id_fk"
  end
end
