class AddLevelAndLinesToScores < ActiveRecord::Migration[5.2]
  def change
  	add_column :scores, :level, :integer
  	add_column :scores, :lines, :integer
  end
end
