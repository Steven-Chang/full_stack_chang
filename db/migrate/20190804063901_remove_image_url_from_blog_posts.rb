class RemoveImageUrlFromBlogPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :blog_posts, :image_url, :string
  end
end
