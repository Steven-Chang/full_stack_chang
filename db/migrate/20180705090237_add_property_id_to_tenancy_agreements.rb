class AddPropertyIdToTenancyAgreements < ActiveRecord::Migration[5.1]
  def change
    add_column :tenancy_agreements, :property_id, :integer
  end
end
