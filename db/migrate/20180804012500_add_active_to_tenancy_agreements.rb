class AddActiveToTenancyAgreements < ActiveRecord::Migration[5.1]
  def change
    add_column :tenancy_agreements, :active, :boolean, default: true
  end
end
