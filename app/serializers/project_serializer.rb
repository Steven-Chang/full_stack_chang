class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :description, :title, :url, :start_date, :end_date

  has_many :attachments
end
