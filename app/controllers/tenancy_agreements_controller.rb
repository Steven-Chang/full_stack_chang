# frozen_string_literal: true

class TenancyAgreementsController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    if params[:property_id]
      @tenancy_agreements = TenancyAgreement.where(:property_id => params[:property_id])
    else
      @tenancy_agreements = TenancyAgreement.all
    end

    if params[:active]
      @tenancy_agreements = @tenancy_agreements.where(active: params[:active] == "true") 
    end

    render :json => @tenancy_agreements
  end
end
