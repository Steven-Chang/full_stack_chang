class EntrySerializer < ActiveModel::Serializer
  attributes :id, :minutes, :date

  belongs_to :aim
end
