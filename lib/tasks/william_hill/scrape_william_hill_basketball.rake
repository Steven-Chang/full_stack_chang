require_relative '../../task_helpers/gambling_helper'

namespace :fsc do
  desc "Scraping William Hill Basketball"
  task :scrape_william_hill_basketball => :environment do

    require 'watir'

    browser = Watir::Browser.new

    browser.goto('https://www.williamhill.com.au/legacysports/SportsGenericTopMenu?sportname=basketball-us')

    match_type = GamblingHelper.find_or_create_match_type( "basketball", "nba" )

    # This goes through all the straight bets
    # so that we can get all the different team names
    browser.elements(css: "a[data-link-bettype]").each do |element|
      if element.attribute_value("data-link-bettype") == "101"
        GamblingHelper.find_or_create_team( element.attribute_value("data-link-competitorname" )
      end
    end

    # This goes through each element with a data--link-eventid
    # Pretty much every bet available on this page
    browser.elements(css: "a[data-link-eventid]").each do |element|
      # This is about creating the nba game
      # The date is wrong unfortunately as it is adjusted fro sydney time or whatever before it's scraped
      bookie_match_id = element.attribute_value("data-link-eventid")
      nba_game = Match.where(:bookie_match_id => bookie_match_id ).first
      unless nba_game
        nba_game = Match.new
        nba_game.bookie_match_id = bookie_match_id
        nba_game.date = browser.element( text: element.attribute_value("data-link-eventname") ).parent.time.attribute_value("data-race-date")
        nba_game.match_type_id = match_type.id
        browser.elements(css: "a[data-link-eventid]").each do |element_two|

          if element_two.attribute_value("data-link-compid") == "1" && element_two.attribute_value("data-link-eventid") == nba_game.bookie_match_id
            away_team_name = element_two.attribute_value("data-link-competitorname").downcase
          end

          if element_two.attribute_value("data-link-compid") == "2" && element_two.attribute_value("data-link-eventid") == nba_game.bookie_match_id
            home_team_name = element_two.attribute_value("data-link-competitorname").downcase
          end
        end
        nba_game.home_id = Team.where(:name => home_team_name).first.id
        nba_game.away_id = Team.where(:name => away_team_name).first.id
        nba_game.save
      end

      # Now that the game has been created
      # Should attach all of the bet's related to it
      # right now the issue is that we're overwriting the first one...
      # An easy fix would be to make sure there's always two
      if element.attribute_value("data-link-bettype") == "102"
        markets = Market.where( :match_id => nba_game.id )
        if element.attribute_value( "data-link-compid" ) == "1"
          market_type = GamblingHelper.find_or_create_market_type( "away line" )
        else
          market_type = GamblingHelper.find_or_create_market_type( "home line" )
        end
        market = markets.where(:market_type_id => market_type.id)
        unless market
          market = Market.new
          market.match_id = nba_game.id
          market.market_type_id = market_type.id
        end
        market.description = element.attribute_value( "data-link-points" ).to_f
        market.odds = element.attribute_value( "data-link-pricetowin" ).to_f

        market.save
      end
    end

    browser.close
  end
end