class DropTableMatches < ActiveRecord::Migration[5.1]
  def change
    drop_table :matches
  end
end