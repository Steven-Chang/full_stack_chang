class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_id, null: false
      t.integer :away_id, null: false
      t.integer :match_type_id, null: false
      t.datetime :date, null: false
      t.integer :home_score
      t.integer :away_score

      t.timestamps null: false
    end
  end
end