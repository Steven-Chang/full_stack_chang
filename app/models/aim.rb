# frozen_string_literal: true

class Aim < ApplicationRecord
  # === ASSOCIATIONS ===
  has_many :entries, dependent: :destroy

  # === VALIDATIONS ===
  validates :description, presence: true

  # === CALLBACKS ===
  after_create :create_initial_entries

  # === INSTANCE METHODS ===
  def create_initial_entries
  	 entries_by_date_in_ascending_order = Entry.order(:date)
    earliest_date = entries_by_date_in_ascending_order.present? ? entries_by_date_in_ascending_order.first.date : Date.current
    latest_date = entries_by_date_in_ascending_order.present? ? entries_by_date_in_ascending_order.last.date : Date.current

    (earliest_date..latest_date).each do |date|
      entries.create(date: date)
    end
  end
end
