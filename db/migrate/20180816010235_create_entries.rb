class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :aim_id, null: false

      t.timestamps
    end
  end
end
