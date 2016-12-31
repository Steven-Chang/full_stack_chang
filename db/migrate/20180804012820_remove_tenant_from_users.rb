class RemoveTenantFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :tenant, :boolean
  end
end
