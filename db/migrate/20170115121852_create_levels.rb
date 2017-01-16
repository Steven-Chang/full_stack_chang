class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :score_id, null: false
      t.integer :level, null: false

      t.timestamps null: false
    end

    add_index :levels, :score_id
  end
end
