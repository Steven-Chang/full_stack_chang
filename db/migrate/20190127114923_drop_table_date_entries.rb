class DropTableDateEntries < ActiveRecord::Migration[5.1]
  def change
    drop_table :date_entries
  end
end
