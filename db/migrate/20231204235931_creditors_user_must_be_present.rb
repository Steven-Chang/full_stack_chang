class CreditorsUserMustBePresent < ActiveRecord::Migration[7.0]
  def change
    change_column :creditors, :user_id, :bigint, null: false
  end
end
