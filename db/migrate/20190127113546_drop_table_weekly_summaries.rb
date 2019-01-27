class DropTableWeeklySummaries < ActiveRecord::Migration[5.1]
  def change
    drop_table :weekly_summaries
  end
end
