class RemoveYoutubeUrl < ActiveRecord::Migration[5.2]
  def change
  	remove_column :blog_posts, :youtube_url, :string
  end
end
