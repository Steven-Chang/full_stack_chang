class CreateTools < ActiveRecord::Migration[6.0]
  def change
    create_table :tools do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :category

      t.timestamps
    end
  end
end
