class TenancyAgreementsController < ApplicationController
  before_action :set_tenancy_agreement, only: [:show, :edit, :update, :destroy, :balance]

  # GET /tenancy_agreements
  # GET /tenancy_agreements.json
  def index
    if params[:property_id]
      @tenancy_agreements = TenancyAgreement.where(:property_id => params[:property_id])
    else
      @tenancy_agreements = TenancyAgreement.all
    end

    render :json => @tenancy_agreements
  end

  # GET /tenancy_agreements/1
  # GET /tenancy_agreements/1.json
  def show
    render :json => @tenancy_agreement
  end

  # GET /tenancy_agreements/new
  def new
    @tenancy_agreement = TenancyAgreement.new
  end

  # GET /tenancy_agreements/1/edit
  def edit
  end

  # POST /tenancy_agreements
  # POST /tenancy_agreements.json
  def create
    @tenancy_agreement = TenancyAgreement.new(tenancy_agreement_params)

    if @tenancy_agreement.save
      render :json => @tenancy_agreement, status: :created
    else
      render :json => @tenancy_agreement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tenancy_agreements/1
  # PATCH/PUT /tenancy_agreements/1.json
  def update
    if @tenancy_agreement.update(tenancy_agreement_params)
      render json: @tenancy_agreement, status: :ok
    else
      render json: @tenancy_agreement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tenancy_agreements/1
  # DELETE /tenancy_agreements/1.json
  def destroy
    @tenancy_agreement.destroy
    respond_to do |format|
      format.html { redirect_to tenancy_agreements_url, notice: 'Tenancy agreement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenancy_agreement
      @tenancy_agreement = TenancyAgreement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tenancy_agreement_params
      params.require(:tenancy_agreement).permit(:user_id, :amount, :starting_date, :property_id, :bond, :active)
    end
end
