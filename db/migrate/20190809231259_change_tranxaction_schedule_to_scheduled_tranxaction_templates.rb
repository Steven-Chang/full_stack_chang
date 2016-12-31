class ChangeTranxactionScheduleToScheduledTranxactionTemplates < ActiveRecord::Migration[5.2]
  def change
  	rename_table :tranxaction_schedules, :scheduled_tranxaction_templates
  end
end
