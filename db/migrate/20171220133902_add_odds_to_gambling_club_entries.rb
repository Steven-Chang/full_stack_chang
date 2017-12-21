class AddOddsToGamblingClubEntries < ActiveRecord::Migration
  def change
    add_column :gambling_club_entries, :odds, :float
  end
end
