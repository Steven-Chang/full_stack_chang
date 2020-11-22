class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.string :identifier, null: false
      t.references :exchange

      t.timestamps
    end
  end
end
