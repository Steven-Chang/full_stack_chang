namespace :fsc do
  desc 'Process scheduled tranxaction templates'
  task :process_scheduled_tranxaction_templates => :environment do
    ScheduledTranxactionTemplate.process
  end
end
