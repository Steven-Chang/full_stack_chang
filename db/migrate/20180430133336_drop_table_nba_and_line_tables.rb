class DropTableNbaAndLineTables < ActiveRecord::Migration
  def change
    drop_table :nba_games
    drop_table :nba_teams
    drop_table :line_markets
  end
end
