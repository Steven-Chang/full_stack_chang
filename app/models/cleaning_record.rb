class CleaningRecord < ApplicationRecord
  belongs_to :cleaning_task
  belongs_to :user
end
