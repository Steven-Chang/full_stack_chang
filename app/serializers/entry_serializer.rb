# frozen_string_literal: true

class EntrySerializer < ActiveModel::Serializer
  attributes :id, :date, :achieved

  belongs_to :aim
end
