class AddTaxToTenancyAgreements < ActiveRecord::Migration[5.1]
  def change
    add_column :tenancy_agreements, :tax, :boolean, default: true
  end
end
