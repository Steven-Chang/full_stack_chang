class Aim < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :weekly_summaries, dependent: :destroy

  def labels
    self.weekly_summaries.order(:start_date).map { |w| "#{ w.start_date } - #{ w.end_date }" }
  end

  def data
    self.weekly_summaries.order(:start_date).pluck(:minutes)
  end
end
