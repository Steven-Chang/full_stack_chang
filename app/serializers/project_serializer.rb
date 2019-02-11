class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :description, :private, :title, :url, :start_date, :end_date

  has_many :attachments
end
