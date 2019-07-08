# frozen_string_literal: true

class AimsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_aim, only: %i[show edit update destroy]

  def index
    @aims = Aim.all

    render json: @aims
  end

  def show
    render json: @aim
  end

  def new
    @aim = Aim.new
  end

  def edit; end

  def create
    @aim = Aim.new(aim_params)

    if @aim.save
      render json: @aim, status: :created
    else
      render json: @aim.errors, status: :unprocessable_entity
    end
  end

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

  def destroy
    @aim.destroy
    respond_to do |format|
      format.html { redirect_to aims_url, notice: 'Aim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_aim
    @aim = Aim.find(params[:id])
  end

  def aim_params
    params.require(:aim).permit(:description)
  end
end
