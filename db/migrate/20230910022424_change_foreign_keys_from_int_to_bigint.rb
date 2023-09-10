class ChangeForeignKeysFromIntToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :payment_summaries, :client_id, :bigint, null: false
    change_column :tenancy_agreements, :property_id, :bigint
    change_column :tenancy_agreements, :user_id, :bigint, null: false
    change_column :tranxactions, :tax_category_id, :bigint
  end
end
