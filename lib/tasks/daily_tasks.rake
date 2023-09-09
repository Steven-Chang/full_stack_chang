desc "Run daily by Heroku Scheduler"
task daily_tasks: :environment do
  ScheduledTranxactionTemplate.process
end
