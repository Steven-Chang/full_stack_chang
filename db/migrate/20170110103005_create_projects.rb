class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :description
      t.string :image_url
      t.string :title, null: false
      t.string :url
      t.datetime :date_added

      t.timestamps null: false
    end
  end
end
