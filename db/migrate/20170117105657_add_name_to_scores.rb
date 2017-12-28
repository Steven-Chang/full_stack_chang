class AddNameToScores < ActiveRecord::Migration
  def change
    add_column :scores, :name, :string

    change_column :scores, :name, :string, :null => false
  end
end
