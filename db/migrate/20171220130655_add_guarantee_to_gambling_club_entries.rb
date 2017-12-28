class AddGuaranteeToGamblingClubEntries < ActiveRecord::Migration
  def change
    add_column :gambling_club_entries, :guarantee, :boolean
  end
end
