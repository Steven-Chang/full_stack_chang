class CreateCleaningTasks < ActiveRecord::Migration
  def change
    create_table :cleaning_tasks do |t|
      t.string :description, null: false
      t.decimal :points, precision: 4, scale: 2, default: 0.0

      t.timestamps null: false
    end
  end
end
