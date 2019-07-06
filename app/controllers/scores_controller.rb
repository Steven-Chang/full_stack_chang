# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :set_project_id

  def index
    render json: Project.find(@project_id).scores.order('score DESC')
  end

  def create
    score = Score.new(score_params)
    score.project_id = @project_id
    if score.save
      render json: score
    else
      render json: score.errors, status: :unprocessable_entity
    end
  end

  private

  def score_params
    params.require(:score)
          .permit(:project_id, :level, :lines, :name, :score)
  end

  def set_project_id
    @project_id = Project.find_by(title: params[:title]).id
  end
end
