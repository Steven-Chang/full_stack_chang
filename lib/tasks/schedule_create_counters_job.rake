# Heroku scheduler runs this every hour

desc "This task is called by the Heroku scheduler add-on"
task schedule_create_counters_job: :environment do
  CreateCountersJob.perform_later
end
