class Aim < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :weekly_summaries, dependent: :destroy

  def labels
    self.weekly_summaries.order(:start_date).map { |w| "#{ w.start_date } - #{ w.end_date }" }
  end

  def data
    self.weekly_summaries.order(:start_date).pluck(:minutes)
  end

  def per_day
    ordered_entries = self.entries.order(:date)
    if ordered_entries.count > 0
      self.weekly_summaries.sum(:minutes) / ( ( Date.today - ordered_entries.first.date ).to_f + 1 )
    else
      0
    end
  end
end
