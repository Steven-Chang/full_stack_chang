class AddTaxToTranxactions < ActiveRecord::Migration[5.1]
  def change
    add_column :tranxactions, :tax, :boolean
  end
end
