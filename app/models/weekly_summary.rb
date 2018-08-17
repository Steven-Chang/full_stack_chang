class WeeklySummary < ApplicationRecord
  has_many :entries

  # Because this method always build up, we just gotta grab the weekly summary with the lastest start_date or end_date and go from there
  def self.create_up_to_date( aim_id, date )
    date_has_weekly_summary = false
    weekly_summary_with_latest_start_date = WeeklySummary.where(aim_id: aim_id).order(:start_date).last

    if weekly_summary_with_latest_start_date
      until date_has_weekly_summary
        if weekly_summary_with_latest_start_date.start_date >= date && weekly_summary_with_latest_start_date.end_date <= date
          date_has_weekly_summary = true
        else
          new_weekly_summary = WeeklySummary.new
          new_weekly_summary.aim_id = aim_id
          new_weekly_summary.minutes = 0
          new_weekly_summary.start_date = weekly_summary_with_latest_start_date.start_date + 7.days
          new_weekly_summary.end_date = weekly_summary_with_latest_start_date.end_date + 7.days
          new_weekly_summary.save
          weekly_summary_with_latest_start_date = new_weekly_summary
        end
      end
    else
      new_weekly_summary = WeeklySummary.new
      new_weekly_summary.aim_id = aim_id
      new_weekly_summary.minutes = 0
      new_weekly_summary.start_date = WeeklySummary.get_date_to_day_of_week( date, "Monday" )
      new_weekly_summary.end_date = WeeklySummary.get_date_to_day_of_week( date, "Sunday" )
      new_weekly_summary.save
    end

    weekly_summary_with_latest_start_date
  end

  def self.get_date_to_day_of_week( date, day_name )
    day_name = day_name.titleize
    monday = date
    while monday.strftime("%A") != "Monday"
      monday = monday - 1.days
    end
    date = monday
    while date.strftime("%A") != day_name
      date = date + 1.days
    end
    date
  end
end
