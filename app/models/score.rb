class Score < ActiveRecord::Base
  belongs_to :project
  has_one :level, dependent: :destroy
  has_one :line, dependent: :destroy
end
