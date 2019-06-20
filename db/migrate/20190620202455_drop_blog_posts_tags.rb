class DropBlogPostsTags < ActiveRecord::Migration[5.1]
  def change
  	drop_table :blog_posts_tags
  end
end
