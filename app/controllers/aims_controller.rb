class AimsController < ApplicationController
  before_action :set_aim, only: [:show, :edit, :update, :destroy]

  # GET /aims
  # GET /aims.json
  def index
    @aims = Aim.all
  end

  # GET /aims/1
  # GET /aims/1.json
  def show
  end

  # GET /aims/new
  def new
    @aim = Aim.new
  end

  # GET /aims/1/edit
  def edit
  end

  # POST /aims
  # POST /aims.json
  def create
    @aim = Aim.new(aim_params)

    respond_to do |format|
      if @aim.save
        format.html { redirect_to @aim, notice: 'Aim was successfully created.' }
        format.json { render :show, status: :created, location: @aim }
      else
        format.html { render :new }
        format.json { render json: @aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aims/1
  # PATCH/PUT /aims/1.json
  def update
    respond_to do |format|
      if @aim.update(aim_params)
        format.html { redirect_to @aim, notice: 'Aim was successfully updated.' }
        format.json { render :show, status: :ok, location: @aim }
      else
        format.html { render :edit }
        format.json { render json: @aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aims/1
  # DELETE /aims/1.json
  def destroy
    @aim.destroy
    respond_to do |format|
      format.html { redirect_to aims_url, notice: 'Aim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aim
      @aim = Aim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aim_params
      params.fetch(:aim, {})
    end
end
