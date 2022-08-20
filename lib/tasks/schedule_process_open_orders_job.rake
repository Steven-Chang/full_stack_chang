# Heroku scheduler runs this every 10 minutes
# This sets the job every 2 minutes from 0, 2, 4, 6, 8

desc "This task is called by the Heroku scheduler add-on"
task schedule_process_open_orders_job: :environment do
  5.times do |n|
    ProcessOpenOrdersJob.set(wait_until: Time.current + (n * 2).minutes).perform_later
  end
end
