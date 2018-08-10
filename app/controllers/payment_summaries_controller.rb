class PaymentSummariesController < ApplicationController
  before_action :set_payment_summary, only: [:show, :edit, :update, :destroy]

  # GET /payment_summaries
  # GET /payment_summaries.json
  def index
    if params[:client_id]
      @payment_summaries = Client.find( params[:client_id] ).payment_summaries
    else
      @payment_summaries = PaymentSummary.all
    end

    render json: @payment_summaries
  end

  # GET /payment_summaries/1
  # GET /payment_summaries/1.json
  def show
  end

  # GET /payment_summaries/new
  def new
    @payment_summary = PaymentSummary.new
  end

  # GET /payment_summaries/1/edit
  def edit
  end

  # POST /payment_summaries
  # POST /payment_summaries.json
  def create
    @payment_summary = PaymentSummary.new( payment_summary_params )
    PaymentSummary.transaction do
      @payment_summary.save

      params[:attachments].each do |attachment|
        Attachment.create(resource_type: "PaymentSummary", resource_id: @payment_summary.id, url: attachment[:url], aws_key: attachment[:aws_key] )
      end if params[:attachments]
    end

    if @payment_summary.persisted?
      render json: @payment_summary, status: :created
    else
      render json: @payment_summary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payment_summaries/1
  # PATCH/PUT /payment_summaries/1.json
  def update
    respond_to do |format|
      if @payment_summary.update(payment_summary_params)
        format.html { redirect_to @payment_summary, notice: 'Payment summary was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_summary }
      else
        format.html { render :edit }
        format.json { render json: @payment_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_summaries/1
  # DELETE /payment_summaries/1.json
  def destroy
    @payment_summary.destroy
    respond_to do |format|
      format.html { redirect_to payment_summaries_url, notice: 'Payment summary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_summary
      @payment_summary = PaymentSummary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_summary_params
      params.require(:payment_summary).permit(:total_tax_withheld, :year_ending, :total_allowances, :client_id, { attachments: [] })
    end
end
