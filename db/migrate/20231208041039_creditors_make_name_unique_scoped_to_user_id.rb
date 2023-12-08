class CreditorsMakeNameUniqueScopedToUserId < ActiveRecord::Migration[7.0]
  def change
    remove_index :creditors, name: "index_creditors_on_LOWER_name"
    add_index :creditors, [:user_id, :name], unique: true
  end
end
