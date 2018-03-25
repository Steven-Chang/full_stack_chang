class AddDateToCleaningRecords < ActiveRecord::Migration
  def change
    add_column :cleaning_records, :date, :date
  end
end
