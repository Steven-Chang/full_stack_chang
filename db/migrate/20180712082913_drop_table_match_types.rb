class DropTableMatchTypes < ActiveRecord::Migration[5.1]
  def change
    drop_table :match_types
  end
end
