class CreateLineMarkets < ActiveRecord::Migration
  def change
    create_table :line_markets do |t|
      t.integer :nba_game_id, null: false
      t.float :home_line
      t.float :away_line
      t.timestamps null: false
    end
  end
end
