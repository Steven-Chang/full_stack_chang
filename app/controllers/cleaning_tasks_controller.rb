class CleaningTasksController < ApplicationController
  # later on we're gonna have to change this because we only want admins to be able to create delete update
  before_filter :authenticate_user!, except: [:index]

  def index
    cleaning_tasks = CleaningTask.all

    respond_to do |format|
      format.json {
        render :json => cleaning_tasks,
        status => 200
      }
    end
  end

  def create
    cleaning_task = CleaningTask.new(cleaning_task_params)
    respond_to do |format|
      if cleaning_task.save
        format.json { render :json => cleaning_task.to_json, status: :created }
      else
        format.json { render json: cleaning_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def cleaning_task_params
    params.require(:cleaning_task).permit(:description)
  end
end
