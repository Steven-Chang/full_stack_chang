class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    projects = Project.all

    respond_to do |format|
      format.json { render :json => projects, :status => 200 }
    end
  end

  def create
    project = Project.new(project_params)
    project.save

    respond_to do |format|
      format.json { render :json => project, :status => 200 }
    end
  end

  private

  def project_params
    params.require(:project).permit(:description, :image_url, :title, :url, :date_added)
  end

end
