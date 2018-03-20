class CreateCleaningRecords < ActiveRecord::Migration
  def change
    create_table :cleaning_records do |t|
      t.integer :user_id, null: false
      t.string :description, null: false
      t.decimal :points, precision: 3, scale: 2, default: 0.0

      t.timestamps null: false
    end
  end
end
