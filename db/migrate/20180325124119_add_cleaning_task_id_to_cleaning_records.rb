class AddCleaningTaskIdToCleaningRecords < ActiveRecord::Migration
  def change
    add_column :cleaning_records, :cleaning_task_id, :integer
  end
end
