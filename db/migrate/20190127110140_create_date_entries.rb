class CreateDateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :date_entries do |t|
      t.date :date, null: false
      t.integer :entry_id, nill: false

      t.timestamps
    end
  end
end
