class BlogPostsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index ]

  def index
    if params["0"]
      tag = params["0"]
      tags = Tag.where('lower(tag) = ?', tag.downcase)
      blog_posts = []
      tags.each do |t|
        blog_posts += t.blog_posts
      end
    else
      blog_posts = BlogPost.all
    end

    respond_to do |format|
      format.json { render :json => blog_posts.to_json(:include => :tags), :status => 200 }
    end
  end

  def create
    blog_post = BlogPost.new(post_params)
    blog_post.save

    if params[:tags]
      params[:tags].each do |tag|
        Tag.where(:tag => tag).first_or_create do |t|
        end
        blog_post.tags << Tag.where(:tag => tag).first
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
    BlogPost.find(params[:id]).destroy

    render json: { message: "removed" }, status: :ok
  end

  private

  def post_params
    params.require(:blog_post).permit(:description, :image_url, :title, :youtube_url, :date_added)
  end

end
