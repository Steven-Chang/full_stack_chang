class DropTableLines < ActiveRecord::Migration[5.2]
  def change
  	drop_table :lines
  end
end
