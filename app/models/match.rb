class Match < ActiveRecord::Base
  has_many :markets, :dependent => :destroy
end
