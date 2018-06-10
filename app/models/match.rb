class Match < ApplicationRecord
  has_many :markets, :dependent => :destroy
end
