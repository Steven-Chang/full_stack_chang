class ScoresController < ApplicationController
  before_action :set_project_id

  # Mass assignment is a feature of Rails which allows an application to create a record from the values of a hash
  # You only need to whitelist params when you are doing mass assignment. 
  # Here we are using params for other things so we don't need to whitelist them!
  def index
    high_scores_and_associations = Score.return_high_scores_and_associations( @project_id )

    respond_to do |format|
      format.json { render :json => high_scores_and_associations, :status => 200 }
    end
  end

  def create
    associations = params[:associations]
    score = Score.new(:name => params[:name], :project_id => @project_id, :score => params[:score])
    score.save
    Score.create_associations_for_score(associations, score)

    redirect_to :action => "index", title: Project.find(@project_id).title, format: :json
  end

  private

  def set_project_id
    @project_id = Project.where(:title => params[:title]).first.id
  end

end
