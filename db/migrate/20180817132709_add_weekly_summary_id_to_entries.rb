class AddWeeklySummaryIdToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :weekly_summary_id, :integer
  end
end
