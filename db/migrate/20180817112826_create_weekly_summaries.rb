class CreateWeeklySummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :weekly_summaries do |t|
      t.integer :aim_id, null: false
      t.integer :minutes
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
