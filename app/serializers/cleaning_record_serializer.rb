class CleaningRecordSerializer < ActiveModel::Serializer
  attributes :id, :date 

  belongs_to :user
  belongs_to :cleaning_task
end
