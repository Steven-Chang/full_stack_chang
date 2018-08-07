class Client < ApplicationRecord
  has_many :jobs, :dependent => :destroy
  has_many :payment_summaries, :dependent => :destroy

  has_many :tranxactables, as: :resource
  has_many :tranxactions, through: :tranxactables, dependent: :destroy

  validates :name, presence: true
end
