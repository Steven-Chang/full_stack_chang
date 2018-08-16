class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :aim_id, null: false
      t.integer :minutes
      t.decimal :amount, precision: 8, scale: 2, default: "0.0"

      t.timestamps
    end
  end
end
