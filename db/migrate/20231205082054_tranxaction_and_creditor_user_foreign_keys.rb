class TranxactionAndCreditorUserForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "creditors", "users", name: "creditors_user_id_fk"
    add_foreign_key "tranxactions", "users", name: "tranxactions_user_id_fk"
  end
end
