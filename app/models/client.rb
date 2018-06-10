class Client < ActiveRecord::Base
  has_many :client_payments, :dependent => :destroy
  has_many :jobs, :dependent => :destroy

  validates :name, presence: true
end
