class RemovePointsFromCleaningRecords < ActiveRecord::Migration
  def change
    remove_column :cleaning_records, :points, :decimal
  end
end
