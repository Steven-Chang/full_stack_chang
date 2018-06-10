class CleaningRecordsController < ApplicationController
  before_action :set_cleaning_record, only: [:destroy]
  # later on we're gonna have to change this because we only want admins to be able to create delete update
  before_action :authenticate_user!, except: [:index]

  def index
    cleaning_records = CleaningRecord.all.order("date DESC")

    respond_to do |format|
      format.json {
        render :json => cleaning_records,
        status => 200
      }
    end
  end

  def create
    cleaning_record = CleaningRecord.new(cleaning_record_params)
    respond_to do |format|
      if cleaning_record.save
        format.json { render :json => cleaning_record, status: :created }
      else
        format.json { render json: cleaning_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cleaning_record.destroy

    render json: { message: "removed" }, status: :ok
  end

  private

  def set_cleaning_record
    @cleaning_record = CleaningRecord.find(params[:id])
  end

  def cleaning_record_params
    params.require(:cleaning_record).permit(:cleaning_task_id, :user_id, :date)
  end
end
