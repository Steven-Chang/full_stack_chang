class CreateTenancyAgreements < ActiveRecord::Migration[5.1]
  def change
    create_table :tenancy_agreements do |t|
      t.integer :user_id, null: false
      t.string :address, null: false
      t.decimal :amount , precision: 8, scale: 2, default: "0.0", null: false
      t.date :starting_date, null: false

      t.timestamps
    end
  end
end
