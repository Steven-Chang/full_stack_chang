class AddTenantToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :tenant, :boolean, default: false
  end
end
