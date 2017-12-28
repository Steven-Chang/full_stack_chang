class CreateNbaGames < ActiveRecord::Migration
  def change
    create_table :nba_games do |t|
      t.string "william_hill_id", null: false
      t.datetime "start_date", null: false
      t.integer "home_id", null: false
      t.integer "away_id", null: false
      t.timestamps null: false
    end
  end
end
