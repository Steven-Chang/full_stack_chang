class RemoveAddressFromTenancyAgreements < ActiveRecord::Migration[5.1]
  def change
    remove_column :tenancy_agreements, :address, :string
  end
end
