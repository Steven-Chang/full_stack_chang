class WeeklySummariesController < ApplicationController
  before_action :set_weekly_summary, only: [:show, :edit, :update, :destroy]

  # GET /weekly_summaries
  # GET /weekly_summaries.json
  def index
    @weekly_summaries = WeeklySummary.all
  end

  # GET /weekly_summaries/1
  # GET /weekly_summaries/1.json
  def show
  end

  # GET /weekly_summaries/new
  def new
    @weekly_summary = WeeklySummary.new
  end

  # GET /weekly_summaries/1/edit
  def edit
  end

  # POST /weekly_summaries
  # POST /weekly_summaries.json
  def create
    @weekly_summary = WeeklySummary.new(weekly_summary_params)

    respond_to do |format|
      if @weekly_summary.save
        format.html { redirect_to @weekly_summary, notice: 'Weekly summary was successfully created.' }
        format.json { render :show, status: :created, location: @weekly_summary }
      else
        format.html { render :new }
        format.json { render json: @weekly_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_summaries/1
  # PATCH/PUT /weekly_summaries/1.json
  def update
    respond_to do |format|
      if @weekly_summary.update(weekly_summary_params)
        format.html { redirect_to @weekly_summary, notice: 'Weekly summary was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_summary }
      else
        format.html { render :edit }
        format.json { render json: @weekly_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_summaries/1
  # DELETE /weekly_summaries/1.json
  def destroy
    @weekly_summary.destroy
    respond_to do |format|
      format.html { redirect_to weekly_summaries_url, notice: 'Weekly summary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_summary
      @weekly_summary = WeeklySummary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_summary_params
      params.fetch(:weekly_summary, {})
    end
end
