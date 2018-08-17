class Entry < ApplicationRecord
  belongs_to :aim
  belongs_to :weekly_summary

  before_create :attach_weekly_summary
  after_create :increase_weekly_summary
  after_destroy :decrease_weekly_summary

  def attach_weekly_summary
    summaries = self.aim.weekly_summaries.where("start_date >= ?", self.date).where("end_date <= ?", self.date)
    if summaries.first
      summary = summaries.first
    else
      summary = WeeklySummary.create_up_to_date( self.aim_id, self.date )
    end
    self.weekly_summary = summary
  end

  def increase_weekly_summary
    summary = self.weekly_summary

    summary.minutes += self.minutes
    summary.save
  end

  def decrease_weekly_summary
    if self.weekly_summary
      summary = self.weekly_summary
      summary.minutes -= self.minutes
      summary.save
    end
  end
end
