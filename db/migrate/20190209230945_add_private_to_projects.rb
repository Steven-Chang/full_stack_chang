class AddPrivateToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :private, :boolean, default: true
  end
end
