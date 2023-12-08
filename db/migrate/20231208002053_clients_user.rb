class ClientsUser < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "clients", "users", name: "clients_user_id_fk"
  end
end
