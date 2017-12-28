class AddWagerToGamblingClubEntries < ActiveRecord::Migration
  def change
    add_column :gambling_club_entries, :wager, :float
  end
end
