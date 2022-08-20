# Heroku scheduler runs this every 10 minutes

desc "This task is called by the Heroku scheduler add-on"
task schedule_accumulate_crypto_job: :environment do
  AccumulateCryptoJob.set(wait_until: Time.zone.now + TradePair::MAX_TRADE_FREQUENCY_IN_SECONDS.seconds).perform_later unless AccumulateCryptoJob.scheduled?
end
