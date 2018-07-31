class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    projects = Project.all

    render :json => projects
  end

  def create
    project = Project.new(project_params)

    Project.transaction do
      project.save

      params[:attachments].each do |attachment|
        Attachment.create(resource_type: "Project", resource_id: project.id, url: attachment[:url], aws_key: attachment[:aws_key] )
      end if params[:attachments]
    end

    if project.persisted?
      render :json => project
    else
      render :json => project.errors
    end
  end

  def destroy
    if Project.find(params[:id]).destroy
      render json: { message: "Removed" }, status: :ok
    else
      render json: { message: "Error" }, status: :expectation_failed
    end
  end

  private

  def project_params
    params.require(:project).permit(:description, :title, :url, :date_added, :end_date)
  end

end
