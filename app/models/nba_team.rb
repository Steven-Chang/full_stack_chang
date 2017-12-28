class NbaTeam < ActiveRecord::Base
  has_many :home_games, :class_name => "NbaGame", :foreign_key => "home_id"
  has_many :away_games, :class_name => "NbaGame", :foreign_key => "away_id"

  def games
    NbaGame.where("home_id = ? or away_id = ?", self.id, self.id)
  end
end
