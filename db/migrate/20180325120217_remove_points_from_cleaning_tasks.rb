class RemovePointsFromCleaningTasks < ActiveRecord::Migration
  def change
    remove_column :cleaning_tasks, :points, :decimal
  end
end
