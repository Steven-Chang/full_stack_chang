# frozen_string_literal: true

class TaxCategoriesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_tax_category, only: %i[show destroy]

  def index
    @tax_categories = if params[:resource_type] && params[:resource_id]
      params[:resource_type].constantize.find(params[:resource_id]).tax_categories
    else
      TaxCategory.all
    end

    render json: @tax_categories
  end

  def show
    render json: @tax_category
  end

  def create
    @tax_category = TaxCategory.new(tax_category_params)

    if @tax_category.save
      render json: @tax_category, status: :created
    else
      render json: @tax_category.errors, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @tax_category.update(tax_category_params)
        format.html { redirect_to @tax_category, notice: 'Tax category was successfully updated.' }
        format.json { render :show, status: :ok, location: @tax_category }
      else
        format.html { render :edit }
        format.json { render json: @tax_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tax_category.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_tax_category
    @tax_category = TaxCategory.find(params[:id])
  end

  def tax_category_params
    params.require(:tax_category).permit(:description)
  end
end
