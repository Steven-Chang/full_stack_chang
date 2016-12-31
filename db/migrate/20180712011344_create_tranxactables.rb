class CreateTranxactables < ActiveRecord::Migration[5.1]
  def change
    create_table :tranxactables do |t|

      t.timestamps
    end
  end
end
