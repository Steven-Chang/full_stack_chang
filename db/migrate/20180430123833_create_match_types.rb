class CreateMatchTypes < ActiveRecord::Migration
  def change
    create_table :match_types do |t|
      t.string :name, null: false
      t.string :league

      t.timestamps null: false
    end
  end
end
