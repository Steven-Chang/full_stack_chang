class AddPrivateToBlogPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :blog_posts, :private, :boolean, default: true
  end
end
