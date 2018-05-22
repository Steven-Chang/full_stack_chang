class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #:validatable

  has_many :cleaning_records, dependent: :destroy
  has_many :rent_transactions, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def cleaning_summary
    summary = {}
    CleaningTask.all.each do |ct|
      summary[ct.id] = CleaningRecord.where(:user_id => self.id).where(:cleaning_task_id => ct.id).length
    end
    summary
  end

  def password
    passwords = {
      "Cheyenne Harmatz" => "cats",
      "Dan Nitarski" => "baker",
      "Isabel Lozano" => "ELVIS",
      "Sid Sahi" => "ronaldo"
    }
    passwords[self.username]
  end

end
