# So what I want done here is the ladbrokes site scraped on the regular to keep a track of details to test...

namespace :fsc do
  desc "Scraping Ladbrokes Tennis Site"
  task :scrape_ladbrokes_tennis => :environment do
    require 'open-uri'
    url = "https://www.ladbrokes.com.au/sports/tennis/"
    doc = Nokogiri::HTML( open( url ) )
    matches = doc.css(".match-listing")
    matches.each do |match|
      link = match["href"]
      competitors = match.css(".match-team").first.text.split(" vs ")
      team_one = competitors.first
      team_two = competitors.second
    end

    url = "https://www.ladbrokes.com.au/sports/tennis/54045178-gp-sar-la-princesse-lalla-meryem/54047900-oksana-kalashnikova-bibiane-schoofs-vs-anna-blinkova-raluca-olaru/"
    doc = Nokogiri::HTML( open( url ) )
    puts doc.css("#sportsOddsOverview")
  end
end