class DropTableLevels < ActiveRecord::Migration[5.2]
  def change
  	drop_table :levels
  end
end
