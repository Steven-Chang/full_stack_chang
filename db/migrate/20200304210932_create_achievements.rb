class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.date :date, null: false
      t.string :description, null: false

      t.references :project, null: false, index: true

      t.timestamps
    end
  end
end
