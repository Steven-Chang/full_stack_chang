class CreateTableBlogPostsTags < ActiveRecord::Migration
  def change
    create_table :blog_posts_tags, id: false do |t|
      t.belongs_to :blog_post, index: true
      t.belongs_to :tag, index: true
    end
  end
end
