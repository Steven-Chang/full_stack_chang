class BlogPostsController < ApplicationController

  def index
    blog_posts = Project.all

    respond_to do |format|
      format.json { render :json => blog_posts, :status => 200 }
    end
  end

  def create
  end

end
