class AimSerializer < ActiveModel::Serializer
  attributes :id, :description, :labels, :data, :per_day
end
