# Heroku scheduler runs this every 10 minutes

desc "This task is called by the Heroku scheduler add-on"
task schedule_accumulate_crypto_job: :environment do
  10.times do |n|
    AccumulateCryptoJob.set(wait_until: Time.current + (n * 1).minutes).perform_later
  end
end
