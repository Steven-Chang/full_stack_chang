class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :project_id, null: false
      t.integer :score, null: false

      t.timestamps null: false
    end

    add_index :scores, :project_id
  end
end
