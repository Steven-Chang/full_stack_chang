class Score < ApplicationRecord
  belongs_to :project
  has_one :level, dependent: :destroy
  has_one :line, dependent: :destroy

  def self.create_associations_for_score(associations, score)
    title = Project.find(score.project_id).title

    create_level_association_for_score(associations["level"], score) if associations["level"]
    create_line_association_for_score(associations["lines"], score) if associations["lines"]
  end

  def self.create_level_association_for_score(level, score)
    new_level = Level.new(:score_id => score.id, :level => level)
    new_level.save
    score.level = new_level
  end

  def self.create_line_association_for_score(lines, score)
    new_line = Line.new(:score_id => score.id, :lines => lines)
    new_level.save
    score.line = new_line
  end

  def self.create_line_association_for_score(lines, score)
    new_line = Line.new(:score_id => score.id, :lines => lines)
    new_line.save
    score.line = new_line
  end

  def self.return_high_scores( project_id )
    Score.where( :project_id => project_id ).order( score: :desc ).limit( 5 )
  end

  def self.return_high_scores_and_associations( project_id )
    high_scores = return_high_scores( project_id )
    title = Project.find( project_id ).title

    if title == "Tetris"
      return_high_scores_and_associations_for_tetris( high_scores )
    end
  end

  def self.return_high_scores_and_associations_for_tetris(high_scores)
    high_scores_and_associations = []

    high_scores.each do |high_score|
      high_score_as_object = {}
      high_score_as_object["score"] = high_score.score
      high_score_as_object["name"] = high_score.name
      high_score_as_object["lines"] = high_score.line.lines
      high_score_as_object["level"] = high_score.level.level
      high_scores_and_associations.push(high_score_as_object)
    end

    high_scores_and_associations
  end

end
