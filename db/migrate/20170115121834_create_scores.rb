class CreateScores < ActiveRecord::Migration[4.2]
  def change
    create_table :scores do |t|
      t.integer :project_id, null: false
      t.integer :score, null: false
      t.integer :level
      t.integer :lines

      t.timestamps null: false
    end

    add_index :scores, :project_id
  end
end
