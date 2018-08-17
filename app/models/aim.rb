class Aim < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :weekly_summaries, dependent: :destroy

  def labels
    self.entries.order(:date).pluck(:date)
  end

  def data
    self.entries.order(:date).pluck(:minutes)
  end
end
