class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :description
      t.string :image_url
      t.string :title, null: false
      t.string :youtube_url
      t.datetime :date_added

      t.timestamps null: false
    end
  end
end
