class ScoresController < ApplicationController

  # Mass assignment is a feature of Rails which allows an application to create a record from the values of a hash
  # You only need to whitelist params when you are doing mass assignment. 
  # Here we are using params for other things so we don't need to whitelist them!
  def index
    high_scores_and_associations = Score.return_high_scores_and_associations( {"title" => params["title"], "numberOfScores" => params["numberOfScores"], "associations" => params["associations"]} )

    respond_to do |format|
      format.json { render :json => high_scores_and_associations, :status => 200 }
    end
  end

end
