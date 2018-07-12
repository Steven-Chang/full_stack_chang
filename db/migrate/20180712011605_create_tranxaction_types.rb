class CreateTranxactionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :tranxaction_types do |t|
      t.string :description, null: false

      t.timestamps
    end
  end
end
