class Score < ActiveRecord::Base
  belongs_to :project
  has_one :level, dependent: :destroy
  has_one :line, dependent: :destroy

  def self.return_high_scores_and_associations( filter_params )
    high_scores = return_high_scores( filter_params )
    high_scores_and_associations = []

    high_scores.each do |high_score|
      high_score_as_object = {}
      high_score_as_object["score"] = high_score.score
      high_score_as_object = add_associations_to_high_score( high_score, high_score_as_object, filter_params["associations"] )
      high_scores_and_associations.push(high_score_as_object)
    end

    high_scores_and_associations
  end

  def self.add_associations_to_high_score( high_score_active_record, high_score_object, array_of_association_names )
    array_of_association_names.each do |association|
      high_score_object[association] = high_score_active_record.send(association)
    end
    high_score_object
  end

  def self.return_high_scores( filter_params )
    Project.where(:title => filter_params["title"]).first.scores.order(score: :desc).limit(filter_params["numberOfScores"])
  end

end
