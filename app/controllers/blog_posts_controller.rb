# frozen_string_literal: true

class BlogPostsController < ApplicationController
  before_action :authenticate_admin_user!, except: [:index]

  def index
    blog_posts = if params['tag']
      BlogPost.joins(:tags)
              .where('lower(tag) = ?', params['tag'].downcase)
              .uniq
    else
      BlogPost.all
    end
    blog_posts = blog_posts.where(private: false) unless current_user&.email == 'prime_pork@hotmail.com'
    blog_posts = blog_posts.where.not('blog_post.id': params['ids_to_exclude']) if params['ids_to_exclude']
    render json: blog_posts.order('date_added DESC').paginate(page: params[:page], per_page: 12)
  end

  def create
    blog_post = BlogPost.new(post_params)
    BlogPost.transaction do
      blog_post.save

      params[:tags]&.each do |tag|
        Tag.where(tag: tag).first_or_create do |t|
        end
        blog_post.tags << Tag.where(tag: tag).first
      end

      params[:attachments]&.each do |attachment|
        Attachment.create(resource_type: 'BlogPost', resource_id: blog_post.id, url: attachment[:url], aws_key: attachment[:aws_key])
      end
    end

    if blog_post.persisted?
      render json: blog_post
    else
      render json: blog_post.errors
    end
  end

  # Gotta figure out the deleting of tags on destroy
  # The key is to destroy all tags that aren't being used anymore
  # tags.each do |tag| if tag.blog_posts.empty? tag.destroy end
  def destroy
    BlogPost.find(params[:id]).destroy

    render json: { message: 'removed' }, status: :ok
  end

  private

  def post_params
    params.require(:blog_post).permit(:description, :guarantee, :image_url, :private, :title, :youtube_url, :date_added)
  end
end
