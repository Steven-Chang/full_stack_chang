class CleaningRecord < ActiveRecord::Base
  belongs_to :cleaning_task
  belongs_to :user
end
