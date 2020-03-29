class CreateProjectsTools < ActiveRecord::Migration[6.0]
  def change
    create_table :projects_tools, id: false do |t|
      t.belongs_to :project
      t.belongs_to :tool
    end
  end
end
