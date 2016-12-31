class CreateTaxCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :tax_categories do |t|
      t.string :description, null: false

      t.timestamps
    end
  end
end
