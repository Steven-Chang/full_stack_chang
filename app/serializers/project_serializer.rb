class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :description, :title, :url, :date_added

  has_many :attachments
end
