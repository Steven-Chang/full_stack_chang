class RemoveEntriesAndAims < ActiveRecord::Migration[6.0]
  def change
    drop_table :entries
    drop_table :aims
  end
end
