class RemoveImageUrlFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :image_url, :string
  end
end
