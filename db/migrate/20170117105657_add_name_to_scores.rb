class AddNameToScores < ActiveRecord::Migration[4.2]
  def change
    add_column :scores, :name, :string, null: false
  end
end
