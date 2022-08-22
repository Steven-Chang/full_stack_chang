# Heroku scheduler runs this every 10 minutes
# This sets the job every 5 minutes from 0, 5

desc "This task is called by the Heroku scheduler add-on"
task schedule_process_open_orders_job: :environment do
  2.times do |n|
    ProcessOpenOrdersJob.set(wait_until: Time.current + (n * 5).minutes).perform_later
  end
end
