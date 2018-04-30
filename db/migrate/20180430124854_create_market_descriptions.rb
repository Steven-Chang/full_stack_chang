class CreateMarketDescriptions < ActiveRecord::Migration
  def change
    create_table :market_descriptions do |t|
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
