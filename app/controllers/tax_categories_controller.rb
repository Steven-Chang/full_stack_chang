# frozen_string_literal: true

class TaxCategoriesController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @tax_categories = if params[:resource_type] && params[:resource_id]
      params[:resource_type].constantize.find(params[:resource_id]).tax_categories
    else
      TaxCategory.all
    end

    render json: @tax_categories
  end
end
