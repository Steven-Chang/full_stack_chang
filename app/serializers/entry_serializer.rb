class EntrySerializer < ActiveModel::Serializer
  attributes :id, :date, :achieved

  belongs_to :aim
end
