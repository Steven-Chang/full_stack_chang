class CreateNbaTeams < ActiveRecord::Migration
  def change
    create_table :nba_teams do |t|
      t.string "name", null: false
      t.timestamps null: false
    end
  end
end
