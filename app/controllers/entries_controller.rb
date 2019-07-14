class EntriesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    render json: Entry.all
  end

  def by_date
    # now that we have a date
    # what i want is to check if we entries for that date and
    number_of_days_back = params["number_of_days_back"].to_i
    if params["date"]
      end_date = params["date"].to_date
    else
      if Entry.all.first
        end_date = Entry.all.order("date DESC").first.date
      else
        end_date = Date.today
      end
    end
    start_date = end_date - number_of_days_back.days
    while(start_date <= end_date) do
      unless Entry.where(date: start_date).count > 0
        Aim.all.each do |aim|
          aim.entries.create(date: start_date)
        end
      end
      start_date += 1.day
    end

    data = Entry.all
      .where("date >= ? and date <= ?", end_date - number_of_days_back.days, end_date)
      .select(:id, :date, :aim_id, :achieved)
      .order("date DESC")
      .group_by{|p| p['date'] }

    respond_with ({ data: data }).to_json
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render json: @entry, status: :created
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.json { render json: @entry, status: :ok }
      else
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:date, :achieved, :aim_id)
    end
end
