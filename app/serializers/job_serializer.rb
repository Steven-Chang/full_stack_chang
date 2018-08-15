class JobSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :description, :cost, :taxable

  belongs_to :client
end
