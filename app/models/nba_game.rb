class NbaGame < ActiveRecord::Base
  belongs_to :home_team, :class_name => "NbaTeam", :foreign_key => "home_id"
  belongs_to :away_team, :class_name => "NbaTeam", :foreign_key => "away_id"

  has_one :line_market
end
