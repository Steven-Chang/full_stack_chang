class ClientsUserCompulsory < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :user_id, :bigint, null: false
  end
end
