namespace :fsc do
  desc "Scraping William Hill"
  task :scrape_william_hill => :environment do

    require 'watir'

    browser = Watir::Browser.new

    browser.goto('https://www.williamhill.com.au/legacysports/SportsGenericTopMenu?sportname=basketball-us')

    # This goes through all the straight bets
    # so that we can get all the different team names
    browser.elements(css: "a[data-link-bettype]").each do |element|
      if element.attribute_value("data-link-bettype") == "101"
        unless NbaTeam.where(:name => element.attribute_value("data-link-competitorname").downcase ).count > 0
          new_team = NbaTeam.new
          new_team.name = element.attribute_value("data-link-competitorname").downcase
          new_team.save
        end
      end
    end

    # This goes through each element with a data--link-eventid
    # Pretty much every bet available on this page
    browser.elements(css: "a[data-link-eventid]").each do |element|
      # This is about creating the nba game
      # The date is wrong unfortunately as it is adjusted fro sydney time or whatever before it's scraped
      nba_game = NbaGame.where(:william_hill_id => element.attribute_value("data-link-eventid") ).first
      unless nba_game
        nba_game = NbaGame.new
        nba_game.william_hill_id = element.attribute_value("data-link-eventid")
        nba_game.start_date = browser.element( text: element.attribute_value("data-link-eventname") ).parent.time.attribute_value("data-race-date")
        home_team_name = nil
        away_team_name = nil
        browser.elements(css: "a[data-link-eventid]").each do |element_two|
          if element_two.attribute_value("data-link-compid") == "1" && element_two.attribute_value("data-link-eventid") == nba_game.william_hill_id
            away_team_name = element_two.attribute_value("data-link-competitorname").downcase
          end

          if element_two.attribute_value("data-link-compid") == "2" && element_two.attribute_value("data-link-eventid") == nba_game.william_hill_id
            home_team_name = element_two.attribute_value("data-link-competitorname").downcase
          end
        end
        nba_game.home_id = NbaTeam.where(:name => home_team_name).first.id
        nba_game.away_id = NbaTeam.where(:name => away_team_name).first.id
        nba_game.save
      end

      # Now that the game has been created
      # Should attach all of the bet's related to it
      if element.attribute_value("data-link-bettype") == "102"
        line_market = LineMarket.where( :nba_game_id => nba_game.id ).first
        unless line_market
          line_market = LineMarket.new
          line_market.nba_game_id = nba_game.id
          line_market.save
        end

        if element.attribute_value( "data-link-compid" ) == "1"
          line_market.away_line = element.attribute_value( "data-link-points" ).to_f
        else
          line_market.home_line = element.attribute_value( "data-link-points" ).to_f
        end
        line_market.save
      end
    end

    browser.close
  end
end