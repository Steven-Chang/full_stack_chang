class AddRoleToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :role, :string
  end
end
