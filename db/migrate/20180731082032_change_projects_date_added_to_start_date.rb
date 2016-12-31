class ChangeProjectsDateAddedToStartDate < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :date_added, :date
    rename_column :projects, :date_added, :start_date
  end
end
