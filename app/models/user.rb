class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #:validatable

  has_many :cleaning_records
  has_many :rent_transactions

  def password
    passwords = {
      "Cheyenne Harmatz" => "cats",
      "Dan Nitarski" => "baker",
      "Isabel Lozano" => "ELVIS",
      "Sid Sahi" => "ronaldo"
    }
    passwords[self.username]
  end

  def cleaning_points
    self.cleaning_records.sum(:points)
  end
end
