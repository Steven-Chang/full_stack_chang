class GamblingClubEntriesController < ApplicationController
  before_filter :authenticate_user!, except: [ :index ]

  def index
    gambling_club_entries = GamblingClubEntry.all

    respond_to do |format|
      format.json { render :json => gambling_club_entries, :status => 200 }
    end
  end

  def create
    gambling_club_entry = GamblingClubEntry.new(entry_params)
    gambling_club_entry.save

    respond_to do |format|
      format.json { render :json => gambling_club_entry, :status => 200 }
    end
  end

  def destroy
    GamblingClubEntry.find(params[:id]).destroy

    render json: { message: "removed" }, status: :ok
  end

  private

  def entry_params
    params.require(:gambling_club_entry).permit()
  end

end
