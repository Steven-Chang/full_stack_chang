class DropColumnMinutesWeeklySummaryId < ActiveRecord::Migration[5.1]
  def change
    remove_column :entries, :minutes, :integer
    remove_column :entries, :weekly_summary_id, :integer
  end
end
