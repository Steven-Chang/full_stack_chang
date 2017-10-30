namespace :fsc do
  desc "Testing Watir Webscraping"
  task :test => :environment do

    require 'watir'

    browser = Watir::Browser.new

    browser.goto('http://stackoverflow.com/')

    puts browser.title

    browser.close
  end
end