class BlogPostsController < ApplicationController

  def index
    blog_posts = BlogPost.all

    respond_to do |format|
      format.json { render :json => blog_posts.to_json(:include => :tags), :status => 200 }
    end
  end

  def create
    blog_post = BlogPost.new(post_params)
    blog_post.save

    params[:tags].each do |tag|
      Tag.where(:tag => tag).first_or_create do |t|
        blog_post.tags << t
      end
    end

    respond_to do |format|
      format.json { render :json => blog_post.to_json(:include => :tags), :status => 200 }
    end
  end

  # Gotta figure out the deleting of tags on destroy
  # The key is to destroy all tags that aren't being used anymore
  # tags.each do |tag| if tag.blog_posts.empty? tag.destroy end
  def destroy

  end

  private

  def post_params
    params.require(:blog_post).permit(:description, :image_url, :title, :youtube_url, :date_added)
  end

end
