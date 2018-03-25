class CleaningRecordsController < ApplicationController
  # later on we're gonna have to change this because we only want admins to be able to create delete update
  before_filter :authenticate_user!

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

  def cleaning_record_params
    params.require(:cleaning_record).permit(:cleaning_task_id, :user_id, :date)
  end
end
