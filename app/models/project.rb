# frozen_string_literal: true

class Project < ApplicationRecord
	# === ASSOCIATIONS ===
  has_many :achievements, dependent: :destroy
  has_many :attachments, as: :resource, dependent: :destroy
  has_many :scores, dependent: :destroy

  # === VALIDATIONS ===
  validates :title, presence: true

  # === INSTANCE METHODS ===
  def duration_formatted
    return if start_date.blank?

    to_date = end_date || Date.current
    number_of_days = to_date - start_date
    string = ''
    years = (number_of_days / 365).to_i
    number_of_days = number_of_days % 365
    months = (number_of_days / 30).to_i
    number_of_days = (number_of_days % 30).to_i
    string += "#{years} year#{years > 1 ? 's' : ''}" if years.positive?
    string += ' ' if string.length.positive?
    string += "#{months} month#{months > 1 ? 's' : ''}" if months.positive?
    string += ' ' if string.length.positive?
    string + "#{number_of_days} day#{number_of_days > 1 ? 's' : ''}"
  end
end
