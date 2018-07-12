class Client < ApplicationRecord
  has_many :client_payments, :dependent => :destroy
  has_many :jobs, :dependent => :destroy

  has_many :tranxactables, as: :resource
  has_many :tranxactions, through: :tranxactables

  validates :name, presence: true
end
