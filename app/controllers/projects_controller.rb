# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_admin_user!, except: %i[index show]
  before_action :set_project, only: %i[destroy show update]

  def index
    projects = if current_user&.email == 'prime_pork@hotmail.com'
      Project.all
    else
      Project.where(private: false)
    end

    current_projects = projects.where(end_date: nil).order('start_date DESC')
    past_projects = projects.where.not(end_date: nil).order('end_date DESC')
    projects = current_projects + past_projects

    render json: projects, current_user: current_user, status: :ok
  end

  def show
    render json: @project
  end

  def create
    project = Project.new(project_params)

    Project.transaction do
      project.save
      params[:attachments]&.each do |attachment|
        Attachment.create(resource_type: 'Project',
                          resource_id: project.id,
                          url: attachment[:url],
                          aws_key: attachment[:aws_key])
      end
    end

    if project.persisted?
      render json: project
    else
      render json: project.errors
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      render json: { message: 'Removed' }, status: :ok
    else
      render json: { message: 'Error' }, status: :expectation_failed
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:description, :private, :title, :url, :start_date, :end_date)
  end
end
