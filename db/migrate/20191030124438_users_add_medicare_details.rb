class UsersAddMedicareDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :medicare_number, :string
    add_column :users, :medicare_expiry, :string
  end
end
