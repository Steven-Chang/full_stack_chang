class CreateCreditors < ActiveRecord::Migration[5.1]
  def change
    create_table :creditors do |t|
      t.string :name, null: false
      t.decimal :balance, precision: 18, scale: 8, default: 0

      t.timestamps
    end
  end
end
