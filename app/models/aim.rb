class Aim < ApplicationRecord
  has_many :entries, dependent: :destroy

  after_create :create_initial_entries

  def create_initial_entries
    earliest_date = Entry.order("date ASC").limit(1).first.date
    latest_date = Entry.order("date DESC").limit(1).first.date

    (earliest_date..latest_date).each do |date|
      self.entries.create(date: date)
    end
  end
end
