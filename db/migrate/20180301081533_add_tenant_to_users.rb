class AddTenantToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tenant, :boolean, default: false
  end
end
