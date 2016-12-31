class AddTaxCategoryIdToTranxactions < ActiveRecord::Migration[5.1]
  def change
    add_column :tranxactions, :tax_category_id, :integer
  end
end
