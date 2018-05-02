# Try to keep everything as lower case when saving...
# Just reduces the chances of doubling up on stuff...

module GamblingHelper
  def self.find_or_create_match_type( match_type, league = nil )
    mt = MatchType.where(:name => match_type )
    if league
      mt = match_type.where(:league => league )
    end
    unless mt
      mt = MatchType.new
      mt.name = match_type
      mt.league = league
      mt.save
    end
    mt
  end

  def self.find_or_create_team( team_name )
    team_name = team_name.downcase
    team = Team.where(:name => team_name ).first
    unless team
      team = Team.new
      team.name = team_name
      team.save
    end
    team
  end

  def self.find_or_create_market_type( market_type )
    mt = MarketType.where(:name => market_type).first
    unless mt
      mt = MarketType.new
      mt.name = market_type
      mt.save
    end
    mt
  end
end