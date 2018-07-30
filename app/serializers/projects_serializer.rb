class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_url, :title, :url, :date_added

  has_many :attachments
end
