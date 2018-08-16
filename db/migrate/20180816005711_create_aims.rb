class CreateAims < ActiveRecord::Migration[5.1]
  def change
    create_table :aims do |t|
      t.string :description, null: false

      t.timestamps
    end
  end
end
