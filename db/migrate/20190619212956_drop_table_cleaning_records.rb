class DropTableCleaningRecords < ActiveRecord::Migration[5.1]
  def change
  	drop_table :cleaning_records
  	drop_table :cleaning_tasks
  	drop_table :client_payments
  	drop_table :jobs
  end
end
