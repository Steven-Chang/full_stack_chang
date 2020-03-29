class CreateForeignKeysForProjectsTools < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "projects_tools", "projects", name: "projects_tools_project_id_fk"
    add_foreign_key "projects_tools", "tools", name: "projects_tools_tool_id_fk"
  end
end
