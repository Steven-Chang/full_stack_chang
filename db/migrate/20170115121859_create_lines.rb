class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :score_id, null: false
      t.integer :lines, null: false

      t.timestamps null: false
    end

    add_index :lines, :score_id
  end
end
