class DropTableMarkets < ActiveRecord::Migration[5.1]
  def change
    drop_table :markets
  end
end
