class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.integer :market_description_id, null: false
      t.integer :match_id, null: false
      t.float :odds, null: false

      t.timestamps null: false
    end
  end
end
