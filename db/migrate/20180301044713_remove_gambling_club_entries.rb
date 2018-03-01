class RemoveGamblingClubEntries < ActiveRecord::Migration
  def change
    drop_table :gambling_club_entries
  end
end
