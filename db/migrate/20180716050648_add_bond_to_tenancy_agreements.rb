class AddBondToTenancyAgreements < ActiveRecord::Migration[5.1]
  def change
    add_column :tenancy_agreements, :bond, :decimal, precision: 18, scale: 8, default: 0
  end
end
