class BlogPostsController < ApplicationController

  def index
    blog_posts = BlogPost.all

    respond_to do |format|
      format.json { render :json => blog_posts, :status => 200 }
    end
  end

  def create
    blog_post = BlogPost.new(post_params)
    blog_post.save

    respond_to do |format|
      format.json { render :json => blog_post, :status => 200 }
    end
  end

  private

  def post_params
    params.require(:blog_post).permit(:description, :image_url, :title, :youtube_url, :date_added)
  end

end
