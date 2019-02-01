class BlogPostSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_url, :private, :title, :youtube_url, :date_added

  has_many :tags
  has_many :attachments
end
