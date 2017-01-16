class Project < ActiveRecord::Base
  has_many :scores, dependent: :destroy
end
