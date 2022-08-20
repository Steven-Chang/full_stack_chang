desc "This task is called by the Heroku scheduler add-on"
task schedule_process_scheduled_tranxaction_templates_job: :environment do
  ProcessScheduledTranxactionTemplatesJob.perform_later
end
