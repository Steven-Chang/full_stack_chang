class TenancyAgreementsController < ApplicationController
  before_action :set_tenancy_agreement, only: [:show, :edit, :update, :destroy]

  # GET /tenancy_agreements
  # GET /tenancy_agreements.json
  def index
    @tenancy_agreements = TenancyAgreement.all
  end

  # GET /tenancy_agreements/1
  # GET /tenancy_agreements/1.json
  def show
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

    respond_to do |format|
      if @tenancy_agreement.save
        format.html { redirect_to @tenancy_agreement, notice: 'Tenancy agreement was successfully created.' }
        format.json { render :show, status: :created, location: @tenancy_agreement }
      else
        format.html { render :new }
        format.json { render json: @tenancy_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tenancy_agreements/1
  # PATCH/PUT /tenancy_agreements/1.json
  def update
    respond_to do |format|
      if @tenancy_agreement.update(tenancy_agreement_params)
        format.html { redirect_to @tenancy_agreement, notice: 'Tenancy agreement was successfully updated.' }
        format.json { render :show, status: :ok, location: @tenancy_agreement }
      else
        format.html { render :edit }
        format.json { render json: @tenancy_agreement.errors, status: :unprocessable_entity }
      end
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
      params.fetch(:tenancy_agreement, {})
    end
end