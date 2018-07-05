class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :address, null: false

      t.timestamps
    end
  end
end
