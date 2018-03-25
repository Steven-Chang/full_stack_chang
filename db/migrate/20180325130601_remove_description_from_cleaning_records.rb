class RemoveDescriptionFromCleaningRecords < ActiveRecord::Migration
  def change
    remove_column :cleaning_records, :description, :string
  end
end
