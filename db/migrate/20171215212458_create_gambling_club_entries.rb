class CreateGamblingClubEntries < ActiveRecord::Migration
  def change
    create_table :gambling_club_entries do |t|
      t.datetime :date, null: false
      t.integer :user_id, null: false
      t.float :amount, null: false
      t.text :description
      t.boolean :gambling
      t.timestamps null: false

    end
  end
end
