class AddEndDateToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :end_date, :date
  end
end
